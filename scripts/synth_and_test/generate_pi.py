#!/usr/bin/env python3

import math
from pathlib import Path
import os, sys


def generate_pi_values(
    a_width: int,
    a_frac: int,
    a_output_path: Path,
):
    """
    Generates the four quadrant delimiters (90, 180, 270, 360 deg) in rads
    :param a_width: total width of fixed-point number
    :param a_frac: fractional width of fixed-point number
    :param a_output_path: where to dump the .txt
    """

    # 1. Calculate values
    val_2_pi = 2.0 * math.pi
    val_pi = math.pi
    val_3_pi_div_2 = 1.5 * math.pi
    val_pi_div_2 = 0.5 * math.pi

    pi_list = [val_2_pi, val_3_pi_div_2, val_pi, val_pi_div_2]

    a_output_path.parent.mkdir(exist_ok=True, parents=True)
    with open(a_output_path, "w") as f:
        for val in pi_list:

            # 2. Convert to fixed-point
            fixed_point_val = int(round(val * (2.0**a_frac)))

            # 3. Format as binary string

            if a_width <= 0:
                raise ValueError(f"Invalid width: {a_width}")
            # produce two's-complement bit pattern of 'width' bits
            mask = (1 << a_width) - 1
            val_masked = mask & fixed_point_val
            angle_bstring = format(val_masked, f"0{a_width}b")

            if len(angle_bstring) != a_width:
                raise ValueError(
                    "Binary string was longer than allowed depth! Actual=",
                    len(angle_bstring),
                    "vs Expected=",
                    a_width,
                )

            f.write(f"{angle_bstring}\n")


if __name__ == "__main__":
    # ======================================================
    # PARAMETERS
    G_WIDTH = 35
    G_FRAC = 30
    G_FILEPATH = Path("../../data/")
    # ======================================================
    generate_pi_values(
        a_width=G_WIDTH,
        a_frac=G_FRAC,
        a_output_path=(G_FILEPATH / f"pi_{G_WIDTH}b{G_FRAC}f.txt"),
    )
    # gen_angle.generate_linear_angles(
    #     a_depth=G_DEPTH,
    #     a_width=G_WIDTH,
    #     a_frac=G_FRAC,
    #     a_output_path=(G_FILEPATH / f"angle_linear_0_{G_DEPTH-1}.txt"),
    # )
