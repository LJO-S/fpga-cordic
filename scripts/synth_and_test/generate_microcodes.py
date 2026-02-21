import math
from pathlib import Path
import os, sys
from bitstring import BitArray
from vunit import json4vhdl

# Gameplan
# 1. Generate one bit row for every step
# 2. Let each function map to a specific row and let the steps be subsequent rows
#   0=SIN_COS=010101010...
#   1=ARC_TAN=011110100...
#   ...
#   14=TANH=110010101
#   15=TANH=111101011
#
# Thus we kind of need a LUT containing the PMEM PTR for each function


class generate_microcodes:

    json_obj = read_json(a_json_filepath)


if __name__ == "__main__":
    print("Hello world!")
