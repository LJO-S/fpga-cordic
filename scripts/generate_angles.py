import numpy
from pathlib import Path
import os, sys


class generate_angle:
    def generate_circ_angles(
        self,
        a_depth: int,
        a_width: int,
        a_frac: int,
        a_output_path: Path,
    ):
        a_output_path.parent.mkdir(exist_ok=True, parents=True)
        with open(a_output_path, "w") as f:
            for i in range(a_depth):

                # 1. Calculate angle
                angle = numpy.arctan(2 ** (-i))

                # 2. Convert to fixed-point
                angle_shift = int(round(angle * (2.0**a_frac)))

                # 3. Format as binary string
                if angle_shift < 0.0:
                    angle_bstring = f"{angle_shift:1{a_width}b}"
                else:
                    angle_bstring = f"{angle_shift:0{a_width}b}"

                if len(angle_bstring) > a_width:
                    raise ValueError(
                        "GEN_CIRC::Binary string was longer than allowed depth!"
                    )

                f.write(f"{angle_bstring}\n")

    def generate_hyper_angles(
        self, a_depth: int, a_width: int, a_frac: int, a_output_path: Path
    ):
        a_output_path.parent.mkdir(exist_ok=True, parents=True)
        with open(a_output_path, "w") as f:
            for i in range(a_depth):

                # 1. Calculate angle
                angle = numpy.arctanh(2 ** (-(i + 1)))

                # 2. Convert to fixed-point
                angle_shift = int(round(angle * (2.0**a_frac)))

                # 3. Format as binary string
                if angle_shift < 0.0:
                    angle_bstring = f"{angle_shift:1{a_width}b}"
                else:
                    angle_bstring = f"{angle_shift:0{a_width}b}"

                if len(angle_bstring) > a_width:
                    raise ValueError(
                        "GEN_HYPER::Binary string was longer than allowed depth!"
                    )

                f.write(f"{angle_bstring}\n")


if __name__ == "__main__":
    # ======================================================
    # PARAMETERS
    G_DEPTH = 40
    G_WIDTH = 32
    G_FRAC = 31
    G_FILEPATH = Path("../data/")
    # ======================================================
    gen_angle = generate_angle()
    gen_angle.generate_circ_angles(
        a_depth=G_DEPTH,
        a_width=G_WIDTH,
        a_frac=G_FRAC,
        a_output_path=(G_FILEPATH / f"angle_circ_0_{G_DEPTH-1}.txt"),
    )
    gen_angle.generate_hyper_angles(
        a_depth=G_DEPTH,
        a_width=G_WIDTH,
        a_frac=G_FRAC,
        a_output_path=(G_FILEPATH / f"angle_hyper_0_{G_DEPTH-1}.txt"),
    )
    gen_angle.generate_linear_angles(
        a_depth=G_DEPTH,
        a_width=G_WIDTH,
        a_frac=G_FRAC,
        a_output_path=(G_FILEPATH / f"angle_linear_0_{G_DEPTH-1}.txt"),
    )
