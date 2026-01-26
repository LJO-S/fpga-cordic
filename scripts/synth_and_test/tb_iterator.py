import math
from pathlib import Path
import os, sys
from vunit import json4vhdl
from bitstring import BitArray

# Custom pkgs
from .generate_angles import generate_angle
from .utils import *


class tb_iterator:
    """
    Allows for 1-step CORDIC operations to be tested
    """

    def pre_config_wrapper(
        self,
        a_full_domain: bool,
        a_json_filepath: str,
        a_type: str,
        a_nbr_of_tests: int,
        a_depth: int,
        a_width: int,
        a_frac: int,
        a_output_path_circ: Path,
        a_output_path_hyper: Path,
    ):
        def pre_config(output_path) -> bool:
            def _format_as_bstring(val_fixed: float):
                if val_fixed < 0.0:
                    angle_bstring = f"{val_fixed:1{a_width}b}"
                else:
                    angle_bstring = f"{val_fixed:0{a_width}b}"

                if len(angle_bstring) > a_width:
                    raise ValueError(
                        "GEN_HYPER::Binary string was longer than allowed depth!"
                    )
                return angle_bstring

            gen_angles_obj = generate_angle()

            # 1. Generate angles
            gen_angles_obj.generate_circ_angles(
                a_depth=a_depth,
                a_width=a_width,
                a_frac=a_frac,
                a_output_path=a_output_path_circ,
            )
            gen_angles_obj.generate_hyper_angles(
                a_depth=a_depth,
                a_width=a_width,
                a_frac=a_frac,
                a_output_path=a_output_path_hyper,
            )

            # 2. Read json and fetch tpyes
            json_obj = read_json(a_json_filepath)

            # 3. Dump to text
            input_path: Path = Path(output_path) / "input_data.txt"
            input_path.parent.mkdir(exist_ok=True, parents=True)
            with open(input_path, "w") as f:
                for i in range(a_nbr_of_tests):
                    # 1. Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type=a_type,
                        a_full_domain=a_full_domain,
                        a_iter=i,
                    )

                    # 2. Convert to fixed-point
                    x_fixed = int(round(x * (2.0**a_frac)))
                    y_fixed = int(round(y * (2.0**a_frac)))
                    z_fixed = int(round(z * (2.0**a_frac)))

                    # 3. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)

                    # 4. Write columns: X  Y  Z
                    f.write(f"{x_bstring}\t{y_bstring}\t{z_bstring}\n")

            return True

        return pre_config

    def post_check_wrapper(
        self, a_type: str, a_frac: int, a_rtol: float = 0.001, a_atol: float = 1e-9
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
            onk = 0
            with open(output_data_path, "r") as f_out, open(
                input_data_path, "r"
            ) as f_in:
                for line in f_out:
                    # print(onk)
                    # onk += 1
                    # print(line)

                    # 1. Read input/output data
                    input_line = f_in.readline()
                    [x_in, y_in, z_in] = input_line.split()
                    output_line = line
                    [x_out, y_out, z_out] = output_line.split()

                    # 2. Convert to float

                    x_in_f = BitArray(bin=x_in).int / (2.0**a_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_frac)
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_frac)

                    # 3. Generate referenced data
                    x_ref, y_ref, z_ref = generete_reference_data(
                        a_type=a_type, x=x_in_f, y=y_in_f, z=z_in_f
                    )
                    # 4. Compare to data output entry
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f, "z_in_deg", np.rad2deg(z_out_f))
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref, "z_in_deg", np.rad2deg(z_ref))
                    print()
                    x_comp = _compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = _compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = _compare_value(actual=z_out_f, reference=z_ref)
                    print("=====================================================")

                    checker = checker and x_comp and y_comp and z_comp

            return checker

        return post_check


if __name__ == "__main__":
    print("hello world!")
