import math
from pathlib import Path
import os, sys
from bitstring import BitArray
from vunit import json4vhdl

# Custom pkgs
from .generate_angles import generate_angle
from .generate_pi import generate_pi_values
from .utils import *


def compare_value(actual, reference):
    if reference is not None:
        match = math.isclose(a=actual, b=reference, rel_tol=0.001, abs_tol=1e-9)
        diff_rel = abs(actual - reference) / (reference + 1e-9)
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


class tb_normalizer:
    """
    Check normalization input/output
    """

    def _LZC(
        self,
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

    def _quadrant_map(self, a_x: float, a_y: float, a_z: float):
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
                        )
                    elif "bitshift_norm" in a_type.lower():
                        x = random.uniform(
                            0, 2.0 ** (a_data_width_denorm - a_data_width_frac - 1)
                        )
                        y = random.uniform(
                            0, 2.0 ** (a_data_width_denorm - a_data_width_frac - 1)
                        )
                        z = random.uniform(
                            0, 2.0 ** (a_data_width_denorm - a_data_width_frac - 1)
                        )
                    elif "quadrant_map" in a_type.lower():
                        # 1. Generate PI values
                        generate_pi_values(
                            a_width=a_data_width_denorm,
                            a_frac=a_data_width_frac,
                            a_output_path=Path(output_path)
                            / f"pi_{a_data_width_denorm}b{a_data_width_frac}f.txt",
                        )
                        # 2. Generate input data
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SIN_COS",
                            a_full_domain=True,
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

    def post_check_wrapper_range_reduce(self, a_frac: int):
        def post_check(output_path: str):
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
                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)
                    n_comp = compare_value(actual=n_out, reference=n_ref)
                    print("=====================================================")

                    checker = checker and x_comp and y_comp and z_comp and n_comp

            return checker

        return post_check

    def post_check_wrapper_bitshift_norm(
        self,
        a_frac: int,
        a_shift_common: bool,
        a_shift_inputs: str,
        a_shift_double: bool,
    ):
        def post_check(output_path: str):

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
                    [x_out, y_out, z_out, x_shift_out, y_shift_out, z_shift_out] = (
                        output_line.split()
                    )

                    # 2. Convert to float

                    x_in_f = BitArray(bin=x_in).int / (2.0**a_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_frac)
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_frac)
                    x_shift_out = BitArray(bin=x_shift_out).int
                    y_shift_out = BitArray(bin=y_shift_out).int
                    z_shift_out = BitArray(bin=z_shift_out).int

                    # 3. Generate referenced data
                    (
                        x_ref,
                        y_ref,
                        z_ref,
                        x_shift_ref,
                        y_shift_ref,
                        z_shift_ref,
                    ) = self._LZC(
                        a_shift_common=a_shift_common,
                        a_shift_inputs=a_shift_inputs,
                        a_shift_double=a_shift_double,
                        a_x=x_in_f,
                        a_y=y_in_f,
                        a_z=z_in_f,
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
                    print("x_out_shift=", x_shift_out)
                    print("y_out_shift=", y_shift_out)
                    print("z_out_shift=", z_shift_out)
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print("x_ref_shift=", x_shift_ref)
                    print("y_ref_shift=", y_shift_ref)
                    print("z_ref_shift=", z_shift_ref)
                    print()
                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)
                    x_shift_comp = compare_value(
                        actual=x_shift_out, reference=x_shift_ref
                    )
                    y_shift_comp = compare_value(
                        actual=y_shift_out, reference=y_shift_ref
                    )
                    z_shift_comp = compare_value(
                        actual=z_shift_out, reference=z_shift_ref
                    )
                    print("=====================================================")

                    checker = (
                        checker
                        and x_comp
                        and y_comp
                        and z_comp
                        and x_shift_comp
                        and y_shift_comp
                        and z_shift_comp
                    )

            return checker

        return post_check

    def post_check_wrapper_quadrant_map(
        self,
        a_frac: int,
    ):
        def post_check(output_path: str):

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
                    [x_out, y_out, z_out, q_out] = output_line.split()

                    # 2. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (2.0**a_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_frac)
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_frac)
                    q_out = BitArray(bin=q_out).uint + 1

                    # 3. Generate referenced data
                    (x_ref, y_ref, z_ref, q_ref) = self._quadrant_map(
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
                    print("q_out=", q_out)
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print("q_ref=", q_ref)
                    print()
                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)
                    q_comp = compare_value(actual=q_out, reference=q_ref)
                    print("=====================================================")

                    checker = checker and x_comp and y_comp and z_comp and q_comp

            return checker

        return post_check


class preproc_checker:

    def pre_config_wrapper(
        self,
        a_json_filepath: str,
        a_type_slv: str,
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

            # Norm type
            bitshift_en = False
            range_reduce_en = False
            quadrant_map_en = False
            type_int = int(a_type_slv)
            if type_int / 100 >= 1:
                quadrant_map_en = True
            if ((type_int / 10) % 10) >= 1:
                range_reduce_en = True
            if (type_int % 10) >= 1:
                bitshift_en = True

            # 1. generate PI values for wrapper
            generate_pi_values(
                a_width=a_data_width_denorm,
                a_frac=a_data_width_frac,
                a_output_path=Path(output_path)
                / f"pi_{a_data_width_denorm}b{a_data_width_frac}f.txt",
            )

            # Dump to text
            input_path: Path = Path(output_path) / "input_data.txt"
            input_path.parent.mkdir(exist_ok=True, parents=True)
            with open(input_path, "w") as f:
                for i in range(a_nbr_of_tests):
                    # 2. Generate input data
                    if bitshift_en == True or quadrant_map_en == True:
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SIN_COS",
                            a_full_domain=True,
                        )
                    elif range_reduce_en is True:
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SINH_COSH",
                            a_full_domain=True,
                        )
                    else:
                        raise KeyError(f"No enabled normalizations!")

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

    def post_check_wrapper(self, a_cfg: dict):
        def post_check(output_path: str):

            checker = True

            # Norm type
            bitshift_en = False
            range_reduce_en = False
            quadrant_map_en = False
            type_int = int(a_cfg["TYPE_SLV"])
            if type_int / 100 >= 1:
                quadrant_map_en = True
            if ((type_int / 10) % 10) >= 1:
                range_reduce_en = True
            if (type_int % 10) >= 1:
                bitshift_en = True

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
                    [
                        x_out,
                        y_out,
                        z_out,
                        x_shift_out,
                        y_shift_out,
                        z_shift_out,
                        q_out,
                        n_out,
                    ] = output_line.split()

                    # 2. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    y_in_f = BitArray(bin=y_in).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    z_in_f = BitArray(bin=z_in).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    x_out_f = BitArray(bin=x_out).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    y_out_f = BitArray(bin=y_out).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    z_out_f = BitArray(bin=z_out).int / (
                        2.0 ** a_cfg["G_DATA_WIDTH_FRAC"]
                    )
                    x_shift_out = BitArray(bin=x_shift_out).int
                    y_shift_out = BitArray(bin=y_shift_out).int
                    z_shift_out = BitArray(bin=z_shift_out).int
                    q_out = BitArray(bin=q_out).uint + 1
                    n_out = BitArray(bin=n_out).int

                    # Create local object
                    tb_normalizer_obj = tb_normalizer()

                    # 3. Generate reference data
                    if bitshift_en and range_reduce_en:
                        # 3. Generate referenced data
                        (
                            x_ref,
                            y_ref,
                            z_ref,
                            x_shift_ref,
                            y_shift_ref,
                            z_shift_ref,
                        ) = tb_normalizer_obj._LZC(
                            a_shift_common=a_cfg["G_SHIFT_COMMON"],
                            a_shift_inputs=a_cfg["G_SHIFT_INPUTS"],
                            a_shift_double=a_cfg["G_SHIFT_DOUBLE"],
                            a_x=x_in_f,
                            a_y=y_in_f,
                            a_z=z_in_f,
                        )
                        x_ref, y_ref, z_ref, n_ref = tb_normalizer_obj._range_reduction(
                            a_x=x_ref, a_y=y_ref, a_z=z_ref
                        )

                        # 4. Compare to data output entry
                        print()
                        print("x_in", x_in_f)
                        print("y_in", y_in_f)
                        print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                        print()
                        print("x_out_shift=", x_shift_out)
                        print("y_out_shift=", y_shift_out)
                        print("z_out_shift=", z_shift_out)
                        print("n_out=", n_out)
                        print()
                        print("x_ref", x_ref)
                        print("y_ref", y_ref)
                        print("z_ref=", z_ref)
                        print("x_ref_shift=", x_shift_ref)
                        print("y_ref_shift=", y_shift_ref)
                        print("z_ref_shift=", z_shift_ref)
                        print("n_ref=", n_ref)
                        print()
                        x_comp = compare_value(actual=x_out_f, reference=x_ref)
                        y_comp = compare_value(actual=y_out_f, reference=y_ref)
                        z_comp = compare_value(actual=z_out_f, reference=z_ref)
                        x_shift_comp = compare_value(
                            actual=x_shift_out, reference=x_shift_ref
                        )
                        y_shift_comp = compare_value(
                            actual=y_shift_out, reference=y_shift_ref
                        )
                        z_shift_comp = compare_value(
                            actual=z_shift_out, reference=z_shift_ref
                        )
                        n_comp = compare_value(actual=n_out, reference=n_ref)
                        print("=====================================================")

                        checker = (
                            checker
                            and x_comp
                            and y_comp
                            and z_comp
                            and x_shift_comp
                            and y_shift_comp
                            and z_shift_comp
                            and n_comp
                        )
                    elif bitshift_en:
                        (
                            x_ref,
                            y_ref,
                            z_ref,
                            x_shift_ref,
                            y_shift_ref,
                            z_shift_ref,
                        ) = tb_normalizer_obj._LZC(
                            a_shift_common=a_cfg["G_SHIFT_COMMON"],
                            a_shift_inputs=a_cfg["G_SHIFT_INPUTS"],
                            a_shift_double=a_cfg["G_SHIFT_DOUBLE"],
                            a_x=x_in_f,
                            a_y=y_in_f,
                            a_z=z_in_f,
                        )
                        x_comp = compare_value(actual=x_out_f, reference=x_ref)
                        y_comp = compare_value(actual=y_out_f, reference=y_ref)
                        z_comp = compare_value(actual=z_out_f, reference=z_ref)
                        x_shift_comp = compare_value(
                            actual=x_shift_out, reference=x_shift_ref
                        )
                        y_shift_comp = compare_value(
                            actual=y_shift_out, reference=y_shift_ref
                        )
                        z_shift_comp = compare_value(
                            actual=z_shift_out, reference=z_shift_ref
                        )
                        # 4. Compare to data output entry
                        print()
                        print("x_in", x_in_f)
                        print("y_in", y_in_f)
                        print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                        print()
                        print("x_out_shift=", x_shift_out)
                        print("y_out_shift=", y_shift_out)
                        print("z_out_shift=", z_shift_out)
                        print()
                        print("x_ref", x_ref)
                        print("y_ref", y_ref)
                        print("z_ref=", z_ref)
                        print("x_ref_shift=", x_shift_ref)
                        print("y_ref_shift=", y_shift_ref)
                        print("z_ref_shift=", z_shift_ref)
                        print()
                        print("=====================================================")
                        checker = (
                            checker
                            and x_comp
                            and y_comp
                            and z_comp
                            and x_shift_comp
                            and y_shift_comp
                            and z_shift_comp
                        )

                    elif quadrant_map_en:
                        (x_ref, y_ref, z_ref, q_ref) = tb_normalizer_obj._quadrant_map(
                            a_x=x_in_f, a_y=y_in_f, a_z=z_in_f
                        )
                        x_comp = compare_value(actual=x_out_f, reference=x_ref)
                        y_comp = compare_value(actual=y_out_f, reference=y_ref)
                        z_comp = compare_value(actual=z_out_f, reference=z_ref)
                        q_comp = compare_value(actual=q_out, reference=q_ref)

                        # 4. Compare to data output entry
                        print()
                        print("x_in", x_in_f)
                        print("y_in", y_in_f)
                        print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                        print()
                        print("x_out", x_out_f)
                        print("y_out", y_out_f)
                        print("z_out=", z_out_f, "z_out_deg", np.rad2deg(z_out_f))
                        print("q_out=", q_out)
                        print()
                        print("x_ref", x_ref)
                        print("y_ref", y_ref)
                        print("z_ref=", z_ref)
                        print("q_ref=", q_ref)
                        print()
                        print("=====================================================")
                        checker = checker and x_comp and y_comp and z_comp and q_comp
                    elif range_reduce_en:
                        # 3. Generate referenced data
                        x_ref, y_ref, z_ref, n_ref = tb_normalizer_obj._range_reduction(
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
                        x_comp = compare_value(actual=x_out_f, reference=x_ref)
                        y_comp = compare_value(actual=y_out_f, reference=y_ref)
                        z_comp = compare_value(actual=z_out_f, reference=z_ref)
                        n_comp = compare_value(actual=n_out, reference=n_ref)
                        print("=====================================================")

                        checker = checker and x_comp and y_comp and z_comp and n_comp

            return checker

        return post_check


if __name__ == "__main__":
    print("hello world!")
