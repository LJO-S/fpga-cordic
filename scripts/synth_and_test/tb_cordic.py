import math
from pathlib import Path
import os, sys
from bitstring import BitArray
from vunit import json4vhdl

# Custom pkgs
from .generate_angles import generate_angle
from .generate_pi import generate_pi_values
from .generate_microcodes import generate_microcode_rom
from .utils import *
from scripts.model.cordic_core import execute_cordic, Function
import scripts.model.cordic_microcodes


class cordic_checker:
    def pre_config_wrapper(
        self, a_json_filepath: str, a_nbr_of_tests: int, a_cfg: dict
    ):
        def pre_config(output_path) -> bool:
            def _format_as_bstring(val_fixed: int):

                if a_cfg["G_DATA_WIDTH"] <= 0:
                    raise ValueError(f'Invalid width: {a_cfg["G_DATA_WIDTH"]}')

                # produce two's-complement bit pattern of 'width' bits
                mask = (1 << a_cfg["G_DATA_WIDTH"]) - 1
                val_masked = mask & val_fixed
                bstring = format(val_masked, f"0{a_cfg['G_DATA_WIDTH']}b")

                if len(bstring) != a_cfg["G_DATA_WIDTH"]:
                    raise ValueError(
                        "Binary string was longer than allowed depth! Actual=",
                        len(bstring),
                        "vs Expected=",
                        a_cfg["G_DATA_WIDTH"],
                    )
                return bstring

            # Read json
            json_obj = read_json(a_json_filepath)

            # Assume microcodes already generated!

            # Generate PI values
            generate_pi_values(
                a_width=a_cfg["G_DATA_WIDTH"],
                a_frac=a_cfg["G_DATA_WIDTH_FRAC"],
                a_output_path=Path(output_path)
                / f"pi_{a_cfg['G_DATA_WIDTH']}b{a_cfg['G_DATA_WIDTH_FRAC']}f.txt",
            )

            # Generate Angle values
            gen_angles_obj = generate_angle()
            gen_angles_obj.generate_circ_angles(
                a_depth=a_cfg["G_NBR_OF_ITERATIONS"],
                a_width=a_cfg["G_DATA_WIDTH_FRAC"]
                + 2,  # Note: +2 to account for sign+uint bit
                a_frac=a_cfg["G_DATA_WIDTH_FRAC"],
                a_output_path=Path(output_path)
                / f"angle_circ_0_{a_cfg['G_NBR_OF_ITERATIONS'] - 1}.txt",
            )
            gen_angles_obj.generate_hyper_angles(
                a_depth=a_cfg["G_NBR_OF_ITERATIONS"],
                a_width=a_cfg["G_DATA_WIDTH_FRAC"]
                + 2,  # Note: +2 to account for sign+uint bit
                a_frac=a_cfg["G_DATA_WIDTH_FRAC"],
                a_output_path=Path(output_path)
                / f"angle_hyper_0_{a_cfg['G_NBR_OF_ITERATIONS'] - 1}.txt",
            )

            # Dump to text
            input_path: Path = Path(output_path) / "input_data.txt"
            input_path.parent.mkdir(exist_ok=True, parents=True)
            with open(input_path, "w") as f:
                for _ in range(a_nbr_of_tests):
                    # 1. Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type=a_cfg["name"],
                        a_full_domain=True,
                        a_width=a_cfg["G_DATA_WIDTH"] - a_cfg["G_DATA_WIDTH_FRAC"],
                        a_include_init=False,
                    )
                    # 2. Convert to fixed-point
                    x_fixed = int(round(x * (2.0 ** a_cfg["G_DATA_WIDTH_FRAC"])))
                    y_fixed = int(round(y * (2.0 ** a_cfg["G_DATA_WIDTH_FRAC"])))
                    z_fixed = int(round(z * (2.0 ** a_cfg["G_DATA_WIDTH_FRAC"])))

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

            # Translator
            a_func_translator = dict(
                SIN_COS=Function.SIN_COS,
                TAN=Function.TAN,
                ARCTAN=Function.ARCTAN,
                MULT=Function.MULT,
                DIV=Function.DIV,
                RECIPROCAL=Function.RECIPROCAL,
                SINH_COSH=Function.SINH_COSH,
                TANH=Function.TANH,
                ARCTANH=Function.ARCTANH,
                SQRT=Function.SQRT,
                LN=Function.LN,
                EXP=Function.EXP,
                POW=Function.POW,
                ARCCOSH=Function.ARCCOSH,
                ARCSINH=Function.ARCSINH,
                CSC=Function.CSC,
                SEC=Function.SEC,
                COT=Function.COT,
                SECH=Function.SECH,
                CSCH=Function.CSCH,
                COTH=Function.COTH,
                ARCSIN=Function.ARCSIN,
                ARCCOS=Function.ARCCOS,
            )

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
                    [x_out, y_out, z_out] = output_line.split()

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

                    # 3. Generate reference data
                    # (
                    #     x_ref,
                    #     y_ref,
                    #     z_ref,
                    # ) = execute_cordic(
                    #     a_func=a_func_translator[a_cfg["name"]],
                    #     a_x=x_in_f,
                    #     a_y=y_in_f,
                    #     a_z=z_in_f,
                    #     a_nbr_of_iterations=a_cfg["G_NBR_OF_ITERATIONS"],
                    # )

                    (
                        x_ref,
                        y_ref,
                        z_ref,
                    ) = generete_reference_data(
                        a_type=a_cfg["name"],
                        x=x_in_f,
                        y=y_in_f,
                        z=z_in_f,
                    )

                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)

                    # 4. Compare to data output entry
                    print()
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f)
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print()
                    print("=====================================================")
                    checker = checker and x_comp and y_comp and z_comp

            return checker

        return post_check
