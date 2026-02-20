import math
from pathlib import Path
import os, sys
from bitstring import BitArray
from vunit import json4vhdl

# Custom pkgs
from .generate_angles import generate_angle
from .generate_pi import generate_pi_values
from .utils import *


class postproc_checker:
    def pre_config_wrapper_bitshift(
        self,
        a_json_filepath: str,
        a_nbr_of_tests: int,
        a_shift_double: bool,
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
                    # Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type="MULT",
                        a_full_domain=True,
                        a_width=a_data_width_denorm - a_data_width_frac,
                    )
                    x_norm, y_norm, z_norm, shift_x, shift_y, shift_z = LZC(
                        a_shift_common=False,
                        a_shift_double=a_shift_double,
                        a_shift_inputs=("x, y, z"),
                        a_x=x,
                        a_y=y,
                        a_z=z,
                    )
                    print("x_norm=", x_norm)
                    print("y_norm=", y_norm)
                    print("z_norm=", z_norm)
                    print("x_shift=", shift_x)
                    print("y_shift=", shift_y)
                    print("z_shift=", shift_z)
                    # 2. Convert to fixed-point
                    x_fixed = int(round(x_norm * (2.0**a_data_width_frac)))
                    y_fixed = int(round(y_norm * (2.0**a_data_width_frac)))
                    z_fixed = int(round(z_norm * (2.0**a_data_width_frac)))

                    # 3. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)
                    x_shift_bstring = _format_as_bstring(shift_x)
                    y_shift_bstring = _format_as_bstring(shift_y)
                    z_shift_bstring = _format_as_bstring(shift_z)

                    # 4. Write columns: X  Y  Z
                    f.write(
                        f"{x_bstring}\t{y_bstring}\t{z_bstring}\t{x_shift_bstring}\t{y_shift_bstring}\t{z_shift_bstring}\n"
                    )

            return True

        return pre_config

    def post_check_wrapper_bitshift(
        self,
        a_mode_rotational: bool,
        a_submode_linear: bool,
        a_shift_double: bool,
        a_data_width_frac: int,
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
                    [x_in, y_in, z_in, x_shift_in, y_shift_in, z_shift_in] = (
                        input_line.split()
                    )
                    output_line = line
                    [x_out, y_out, z_out] = output_line.split()

                    # 2. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (2.0**a_data_width_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_data_width_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_data_width_frac)
                    x_out_f = BitArray(bin=x_out).uint / (2.0**a_data_width_frac)
                    y_out_f = BitArray(bin=y_out).uint / (2.0**a_data_width_frac)
                    z_out_f = BitArray(bin=z_out).uint / (2.0**a_data_width_frac)
                    x_shift_in = BitArray(bin=x_shift_in).int
                    y_shift_in = BitArray(bin=y_shift_in).int
                    z_shift_in = BitArray(bin=z_shift_in).int

                    # 3. Generate reference data
                    (
                        x_ref,
                        y_ref,
                        z_ref,
                    ) = anti_LZC(
                        a_mode_rotational=a_mode_rotational,
                        a_submode_linear=a_submode_linear,
                        a_shift_double=a_shift_double,
                        a_x=x_in_f,
                        a_y=y_in_f,
                        a_z=z_in_f,
                        a_x_shift=x_shift_in,
                        a_y_shift=y_shift_in,
                        a_z_shift=z_shift_in,
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
                    print("x_in_shift=", x_shift_in)
                    print("y_in_shift=", y_shift_in)
                    print("z_in_shift=", z_shift_in)
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

    def pre_config_wrapper_quadrant_map(
        self,
        a_json_filepath: str,
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
                    # Generate PI list
                    generate_pi_values(
                        a_width=a_data_width_denorm,
                        a_frac=a_data_width_frac,
                        a_output_path=Path(output_path)
                        / f"pi_{a_data_width_denorm}b{a_data_width_frac}f.txt",
                    )
                    # Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type="SIN_COS",
                        a_full_domain=True,
                        a_width=a_data_width_denorm - a_data_width_frac,
                    )
                    x_norm, y_norm, z_norm, quadrant = quadrant_map(a_x=x, a_y=y, a_z=z)

                    # 2. Convert to fixed-point
                    x_fixed = int(round(x_norm * (2.0**a_data_width_frac)))
                    y_fixed = int(round(y_norm * (2.0**a_data_width_frac)))
                    z_fixed = int(round(z_norm * (2.0**a_data_width_frac)))

                    # 3. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)
                    q_bstring = _format_as_bstring(quadrant - 1)

                    # 4. Write columns: X  Y  Z
                    f.write(f"{x_bstring}\t{y_bstring}\t{z_bstring}\t{q_bstring}\n")

            return True

        return pre_config

    def post_check_wrapper_quadrant_map(
        self,
        a_data_width_frac: int,
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
                    [x_in, y_in, z_in, q_in] = input_line.split()
                    output_line = line
                    [x_out, y_out, z_out] = output_line.split()

                    # 2. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (2.0**a_data_width_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_data_width_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_data_width_frac)
                    q_in = BitArray(bin=q_in).uint + 1
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_data_width_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_data_width_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_data_width_frac)

                    # 3. Generate reference data
                    (
                        x_ref,
                        y_ref,
                        z_ref,
                    ) = anti_quadrant_map(
                        a_x=x_in_f, a_y=y_in_f, a_z=z_in_f, a_quadrant=q_in
                    )

                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)

                    # 4. Compare to data output entry
                    print()
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print("q_in=", q_in)
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f, "z_out_deg", np.rad2deg(z_out_f))
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print()
                    print("=====================================================")
                    checker = checker and x_comp and y_comp and z_comp

            return checker

        return post_check

    def pre_config_wrapper_range_reduce(
        self,
        a_json_filepath: str,
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
                    # Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type="SINH_COSH",
                        a_full_domain=True,
                        a_width=a_data_width_denorm - a_data_width_frac,
                    )
                    # Normalize
                    x_norm, y_norm, z_norm = x, y, z
                    print("x_norm=", x_norm)
                    print("y_norm=", y_norm)
                    print("z_norm=", z_norm)

                    # Range Reduction
                    x_norm, y_norm, z_norm, n = range_reduction(
                        a_x=x_norm, a_y=y_norm, a_z=z_norm
                    )

                    print("yooiign=", n)

                    # 2. Convert to fixed-point
                    x_fixed = int(round(x_norm * (2.0**a_data_width_frac)))
                    y_fixed = int(round(y_norm * (2.0**a_data_width_frac)))
                    z_fixed = int(round(z_norm * (2.0**a_data_width_frac)))
                    shift_x = 0

                    # 3. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)
                    n_bstring = _format_as_bstring(n)
                    x_shift_bstring = _format_as_bstring(shift_x)

                    # 4. Write columns: X  Y  Z
                    f.write(
                        f"{x_bstring}\t{y_bstring}\t{z_bstring}\t{n_bstring}\t{x_shift_bstring}\n"
                    )

            return True

        return pre_config

    def post_check_wrapper_range_reduce(
        self,
        a_mode_vectoring: bool,
        a_submode_hyperbolic: bool,
        a_reduction_reconstruct: bool,
        a_data_width_denorm: int,
        a_data_width_frac: int,
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
                    [x_in, y_in, z_in, n_in, x_shift_in] = input_line.split()
                    output_line = line
                    [x_out, y_out, z_out] = output_line.split()

                    # 2. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (2.0**a_data_width_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**a_data_width_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**a_data_width_frac)
                    n_in = BitArray(bin=n_in).int
                    x_shift_in = BitArray(bin=x_shift_in).int
                    x_out_f = BitArray(bin=x_out).int / (2.0**a_data_width_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**a_data_width_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**a_data_width_frac)

                    # 3. Generate reference data
                    (
                        x_ref,
                        y_ref,
                        z_ref,
                    ) = anti_range_reduction(
                        a_mode_vectoring=a_mode_vectoring,
                        a_submode_hyperbolic=a_submode_hyperbolic,
                        a_reduction_reconstruct=a_reduction_reconstruct,
                        a_int_width=a_data_width_denorm - a_data_width_frac - 1,
                        a_range_n=n_in,
                        a_shift_x=x_shift_in,
                        a_x=x_in_f,
                        a_y=y_in_f,
                        a_z=z_in_f,
                    )

                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)

                    # 4. Compare to data output entry
                    print()
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print("n_in", n_in)
                    print("x_sh_in", x_shift_in)
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f, "z_out_deg", np.rad2deg(z_out_f))
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print()
                    print("=====================================================")
                    checker = checker and x_comp and y_comp and z_comp

            return checker

        return post_check

    def pre_config_wrapper(
        self, a_json_filepath: str, a_nbr_of_tests: int, a_cfg: dict
    ):
        data_width_denorm = int(a_cfg["G_DATA_WIDTH_DENORM"])
        data_width_frac = int(a_cfg["G_DATA_WIDTH_FRAC"])

        def pre_config(output_path) -> bool:
            def _format_as_bstring(val_fixed: int):

                if data_width_denorm <= 0:
                    raise ValueError(f"Invalid width: {data_width_denorm}")

                # produce two's-complement bit pattern of 'width' bits
                mask = (1 << data_width_denorm) - 1
                val_masked = mask & val_fixed
                angle_bstring = format(val_masked, f"0{data_width_denorm}b")

                if len(angle_bstring) != data_width_denorm:
                    raise ValueError(
                        "Binary string was longer than allowed depth! Actual=",
                        len(angle_bstring),
                        "vs Expected=",
                        data_width_denorm,
                    )
                return angle_bstring

            # Read json
            json_obj = read_json(a_json_filepath)

            # Generate PI data
            generate_pi_values(
                a_width=data_width_denorm,
                a_frac=data_width_frac,
                a_output_path=Path(output_path)
                / f"pi_{data_width_denorm}b{data_width_frac}f.txt",
            )

            # Fetch norms
            norm_en = int(a_cfg["norm_en"])
            range_reduce_en = int(a_cfg["reduction_en"])
            range_reduce_reconstruct = int(a_cfg["reduction_reconstruct"])
            quadrant_en = int(a_cfg["quadrant_en"])

            # Dump to text
            input_path: Path = Path(output_path) / "input_data.txt"
            input_path.parent.mkdir(exist_ok=True, parents=True)
            with open(input_path, "w") as f:
                for i in range(a_nbr_of_tests):

                    # 1. Generate input data
                    x, y, z = generate_input_data(
                        a_json_obj=json_obj,
                        a_type="SIN_COS",
                        a_full_domain=True,
                        a_width=data_width_denorm - data_width_frac,
                    )
                    if range_reduce_en:
                        x, y, z = generate_input_data(
                            a_json_obj=json_obj,
                            a_type="SINH_COSH",
                            a_full_domain=True,
                            a_width=data_width_denorm - data_width_frac,
                        )

                    # 2. Normalize
                    x_norm, y_norm, z_norm = x, y, z

                    # Bitshift Normalization
                    x_shift, y_shift, z_shift = 0, 0, 0
                    if norm_en:
                        # Fetch input shifts
                        shift_inputs_int = int(a_cfg["norm_input"])
                        shift_inputs_tuple = tuple()
                        shift_inputs_list = list()
                        if shift_inputs_int % 2 == 1:
                            shift_inputs_list.append("x")
                        if int(shift_inputs_int / 10) % 2 == 1:
                            shift_inputs_list.append("y")
                        if int(shift_inputs_int / 100) % 2 == 1:
                            shift_inputs_list.append("z")
                        shift_inputs_tuple = tuple(shift_inputs_list)

                        x_norm, y_norm, z_norm, x_shift, y_shift, z_shift = LZC(
                            a_shift_common=False,
                            a_shift_double=int(a_cfg["norm_shift_double"]),
                            a_shift_inputs=shift_inputs_tuple,
                            a_x=x_norm,
                            a_y=y_norm,
                            a_z=z_norm,
                        )

                    # Range reduction
                    n = 0
                    if range_reduce_en:
                        x_norm, y_norm, z_norm, n = range_reduction(
                            a_x=x_norm, a_y=y_norm, a_z=z_norm
                        )

                    # Quadrant Map
                    q = 1
                    if quadrant_en:
                        x_norm, y_norm, z_norm, q = quadrant_map(
                            a_x=x_norm, a_y=y_norm, a_z=z_norm
                        )

                    # 3. Convert to fixed-point
                    x_fixed = int(round(x_norm * (2.0**data_width_frac)))
                    y_fixed = int(round(y_norm * (2.0**data_width_frac)))
                    z_fixed = int(round(z_norm * (2.0**data_width_frac)))

                    # 4. Format as binary string
                    x_bstring = _format_as_bstring(x_fixed)
                    y_bstring = _format_as_bstring(y_fixed)
                    z_bstring = _format_as_bstring(z_fixed)
                    x_sh_bstring = _format_as_bstring(x_shift)
                    y_sh_bstring = _format_as_bstring(y_shift)
                    z_sh_bstring = _format_as_bstring(z_shift)
                    n_bstring = _format_as_bstring(n)
                    q_bstring = _format_as_bstring(q - 1)

                    # 4. Write columns: X  Y  Z
                    f.write(
                        f"{x_bstring}\t{y_bstring}\t{z_bstring}\t{x_sh_bstring}\t{y_sh_bstring}\t{z_sh_bstring}\t{n_bstring}\t{q_bstring}\n"
                    )

            return True

        return pre_config

    def post_check_wrapper(self, a_cfg: dict):
        def post_check(output_path: str):

            checker = True

            # 0. Loop for data output entries:
            input_data_path: Path = Path(output_path) / "input_data.txt"
            output_data_path: Path = Path(output_path) / "output_data.txt"

            # Fetch some general values
            data_width_denorm = int(a_cfg["G_DATA_WIDTH_DENORM"])
            data_width_norm = int(a_cfg["G_DATA_WIDTH_NORM"])
            data_width_frac = int(a_cfg["G_DATA_WIDTH_FRAC"])

            # Fetch norms
            norm_en = int(a_cfg["norm_en"])
            range_reduce_en = int(a_cfg["reduction_en"])
            quadrant_en = int(a_cfg["quadrant_en"])

            with open(output_data_path, "r") as f_out, open(
                input_data_path, "r"
            ) as f_in:
                for line in f_out:

                    # 1. Read input/output data
                    input_line = f_in.readline()
                    [
                        x_in,
                        y_in,
                        z_in,
                        x_shift_in,
                        y_shift_in,
                        z_shift_in,
                        n_in,
                        q_in,
                    ] = input_line.split()
                    output_line = line
                    [x_out, y_out, z_out] = output_line.split()

                    # 2A. Slice out bits
                    x_in = x_in[data_width_denorm - data_width_norm :]
                    y_in = y_in[data_width_denorm - data_width_norm :]
                    z_in = z_in[data_width_denorm - data_width_norm :]

                    # 2B. Convert to float
                    x_in_f = BitArray(bin=x_in).int / (2.0**data_width_frac)
                    y_in_f = BitArray(bin=y_in).int / (2.0**data_width_frac)
                    z_in_f = BitArray(bin=z_in).int / (2.0**data_width_frac)
                    x_shift_in = BitArray(bin=x_shift_in).int
                    y_shift_in = BitArray(bin=y_shift_in).int
                    z_shift_in = BitArray(bin=z_shift_in).int
                    n_in = BitArray(bin=n_in).int
                    q_in = BitArray(bin=q_in).uint + 1
                    x_out_f = BitArray(bin=x_out).int / (2.0**data_width_frac)
                    y_out_f = BitArray(bin=y_out).int / (2.0**data_width_frac)
                    z_out_f = BitArray(bin=z_out).int / (2.0**data_width_frac)

                    # 3. De-Normalize
                    x_ref, y_ref, z_ref = x_in_f, y_in_f, z_in_f

                    # Bitshift Norm
                    mode_rotational = False
                    if int(a_cfg["G_MODE"]) == 0:
                        mode_rotational = True
                    submode_linear = False
                    submode_hyper = False
                    if int(a_cfg["G_SUBMODE"]) == 0:
                        submode_hyper = True
                    elif int(a_cfg["G_SUBMODE"]) >= 2:
                        submode_linear = True
                    if norm_en:
                        x_ref, y_ref, z_ref = anti_LZC(
                            a_mode_rotational=mode_rotational,
                            a_submode_linear=submode_linear,
                            a_shift_double=int(a_cfg["norm_shift_double"]),
                            a_x=x_ref,
                            a_y=y_ref,
                            a_z=z_ref,
                            a_x_shift=x_shift_in,
                            a_y_shift=y_shift_in,
                            a_z_shift=z_shift_in,
                        )

                    # Range Reduction
                    if range_reduce_en:
                        (
                            x_ref,
                            y_ref,
                            z_ref,
                        ) = anti_range_reduction(
                            a_mode_vectoring=not (mode_rotational),
                            a_submode_hyperbolic=submode_hyper,
                            a_reduction_reconstruct=int(a_cfg["reduction_reconstruct"]),
                            a_int_width=data_width_denorm - data_width_frac - 1,
                            a_range_n=n_in,
                            a_shift_x=x_shift_in,
                            a_x=x_ref,
                            a_y=y_ref,
                            a_z=z_ref,
                        )

                    if quadrant_en:
                        (
                            x_ref,
                            y_ref,
                            z_ref,
                        ) = anti_quadrant_map(
                            a_x=x_ref, a_y=y_ref, a_z=z_ref, a_quadrant=q_in
                        )

                    x_comp = compare_value(actual=x_out_f, reference=x_ref)
                    y_comp = compare_value(actual=y_out_f, reference=y_ref)
                    z_comp = compare_value(actual=z_out_f, reference=z_ref)

                    # 4. Compare to data output entry
                    print()
                    print("x_in", x_in_f)
                    print("y_in", y_in_f)
                    print("z_in=", z_in_f, "z_in_deg", np.rad2deg(z_in_f))
                    print("x_shift_in", x_shift_in)
                    print("x_shift_in", y_shift_in)
                    print("x_shift_in", z_shift_in)
                    print("n_in", n_in)
                    print("q_in", q_in)
                    print()
                    print("x_out", x_out_f)
                    print("y_out", y_out_f)
                    print("z_out=", z_out_f, "z_out_deg", np.rad2deg(z_out_f))
                    print()
                    print("x_ref", x_ref)
                    print("y_ref", y_ref)
                    print("z_ref=", z_ref)
                    print()
                    print("=====================================================")
                    checker = checker and x_comp and y_comp and z_comp

            return checker

        return post_check
