import math
from pathlib import Path
import os, sys
from bitstring import BitArray
from vunit import json4vhdl

# Custom pkgs
from .generate_angles import generate_angle
from .utils import *


class tb_normalizer:
    """
    Check normalization input/output
    """

    def _LZC(
        a_shift_common: bool,
        a_shift_inputs: tuple,
        a_shift_double: bool,
        a_x: float,
        a_y: float,
        a_z: float,
    ):
        """
        Normalize (x,y) by shifting so that abs(x) is in [1,2) (or similar)
        """

        # 1. Calculate independent shifts
        shift_x, shift_y, shift_z = 0, 0, 0
        if "x" in a_shift_inputs and a_x != 0:
            shift_x = int(math.floor(math.log2(abs(a_x))))
        if "y" in a_shift_inputs and a_y != 0:
            shift_y = int(math.floor(math.log2(abs(a_y))))
        if "z" in a_shift_inputs and a_z != 0:
            shift_z = int(math.floor(math.log2(abs(a_z))))

        # 2. Enforce common shifting for Vectoring
        # ... If we are doing geometric vectroing (Atan, Sqrt, Ln) then X and Y are vectors.
        # If vectors they must scale together to preserve angle
        if a_shift_common:
            common_shift = max(shift_x, shift_y)
            shift_x = common_shift
            shift_y = common_shift

        # 3. Enforce Even Shifting (Crucial for SQRT)
        if a_shift_double:
            # Force shift to be even (floor to nearest even number)
            # e.g., 5 -> 4, -5 -> -6
            if shift_x % 2 != 0:
                shift_x -= 1
            if shift_y % 2 != 0:
                shift_y -= 1

        # 4. Apply shifts
        x_norm = a_x / (2.0**shift_x)
        y_norm = a_y / (2.0**shift_y)
        z_norm = a_z / (2.0**shift_z)

        return x_norm, y_norm, z_norm, shift_x, shift_y, shift_z

    def _range_reduction(self, a_x: float, a_y: float, a_z: float):
        """
        Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
        This variant reduces by integer multiples of ln(2): z = r + n*ln2
        """
        ln2 = math.log(2.0)
        # In FPGA, store log2(e) = 1/ln(2) ~= 1.442695 as a constant
        # ... also store ln(2) of course
        n = int(math.floor(a_z / ln2))
        r = a_z - (n * ln2)
        return a_x, a_y, r, n

    def _quadrant_map(a_x: float, a_y: float, a_z: float):
        """
        Map angle z into the principal quadrant [0, pi/2).
        Returns (x', y', z_corr, quadrant) where quadrant in {1,2,3,4}.
        """
        # Mapping z_corr to [0,90] deg
        two_pi = 2.0 * math.pi
        z_mod = a_z % two_pi  # normalize to [0,2pi)
        if 0.0 <= z_mod < math.pi / 2.0:
            quadrant = 1
            z_corr = z_mod
        elif math.pi / 2.0 <= z_mod < math.pi:
            quadrant = 2
            z_corr = math.pi - z_mod
        elif math.pi <= z_mod < 3 * math.pi / 2:
            quadrant = 3
            z_corr = z_mod - math.pi
        else:
            quadrant = 4
            z_corr = two_pi - z_mod
        return a_x, a_y, z_corr, quadrant

    def pre_config_wrapper(
        self,
        a_json_filepath: str,
        a_type: str,
        a_nbr_of_tests: int,
        a_data_width_denorm: int,
        a_data_width_frac: int,
    ):
        def pre_config(output_path) -> bool:
            def _format_as_bstring(val_fixed: int):

                if a_data_width_denorm <= 0:
                    raise ValueError(f"Invalid width: {a_data_width_denorm}")

                # produce two's-complement bit pattern of 'width' bits
                mask = (1 << a_data_width_denorm) - 1
                val_masked = mask & val_fixed
                angle_bstring = format(val_masked, f"0{a_data_width_denorm}b")

                if len(angle_bstring) != a_data_width_denorm:
                    raise ValueError(
                        "Binary string was longer than allowed depth! Actual=",
                        len(angle_bstring),
                        "vs Expected=",
                        a_data_width_denorm,
                    )
                return angle_bstring

            # Read json
            json_obj = read_json(a_json_filepath)

            # Dump to text
            input_path: Path = Path(output_path) / "input_data.txt"
            input_path.parent.mkdir(exist_ok=True, parents=True)
            with open(input_path, "w") as f:
                for i in range(a_nbr_of_tests):
                    # 1. Generate input data

                    # Test normalization using the functions which actually needs them
                    if "range_reduce" in a_type.lower():
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SINH_COSH",
                            a_full_domain=True,
                            a_iter=i,
                        )
                    elif "bitshift" in a_type.lower():
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="MULTIPLICATION",
                            a_full_domain=True,
                            a_iter=i,
                        )
                    elif "quadrant_map" in a_type.lower():
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SIN_COS",
                            a_full_domain=True,
                            a_iter=i,
                        )
                    else:
                        raise KeyError(f"Unknown norm type! {{{a_type}}}")

                    # 2. Convert to fixed-point
                    x_fixed = int(round(x * (2.0**a_data_width_frac)))
                    y_fixed = int(round(y * (2.0**a_data_width_frac)))
                    z_fixed = int(round(z * (2.0**a_data_width_frac)))

                    # 3. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)

                    # 4. Write columns: X  Y  Z
                    f.write(f"{x_bstring}\t{y_bstring}\t{z_bstring}\n")

            return True

        return pre_config

    def post_check_wrapper_range_reduce(
        self, a_frac: int, a_rtol: float = 0.001, a_atol: float = 1e-9
    ):
        def post_check(output_path: str):
            def _compare_value(actual, reference):
                if reference is not None:
                    match = math.isclose(
                        a=actual, b=reference, rel_tol=a_rtol, abs_tol=a_atol
                    )
                    diff_rel = abs(actual - reference) / (reference + a_atol)
                    if not match:
                        print(
                            f"Mismatch! Reference={reference} vs Actual={actual} <===> %diff={100.0 - diff_rel*100.0}"
                        )
                        return False
                    else:
                        print(
                            f"Pass!! Reference={reference} vs Actual={actual} <===> %diff={100.0 - diff_rel*100.0}"
                        )
                return True

            checker = True

            # 0. Loop for data output entries:
            input_data_path: Path = Path(output_path) / "input_data.txt"
            output_data_path: Path = Path(output_path) / "output_data.txt"

            with open(output_data_path, "r") as f_out, open(
                input_data_path, "r"
            ) as f_in:
                for line in f_out:

                    # 1. Read input/output data
                    input_line = f_in.readline()
                    [x_in, y_in, z_in] = input_line.split()
                    output_line = line
                    [x_out, y_out, z_out, n_out] = output_line.split()

                    # 2. Convert to float

                    x_in_f = BitArray(bin=x_in).int / (2.0**a_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_frac)
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_frac)
                    n_out = BitArray(bin=n_out).int

                    # 3. Generate referenced data
                    x_ref, y_ref, z_ref, n_ref = self._range_reduction(
                        a_x=x_in_f, a_y=y_in_f, a_z=z_in_f
                    )

                    # 4. Compare to data output entry
                    print()
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f, "z_out_deg", np.rad2deg(z_out_f))
                    print("n_out=", n_out)
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print("n_ref=", n_ref)
                    print()
                    x_comp = _compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = _compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = _compare_value(actual=z_out_f, reference=z_ref)
                    n_comp = _compare_value(actual=n_out, reference=n_ref)
                    print("=====================================================")

                    checker = checker and x_comp and y_comp and z_comp and n_comp

            return checker

        return post_check


if __name__ == "__main__":
    print("hello world!")
