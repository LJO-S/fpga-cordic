#!/usr/bin/env python3

# ============================================================
from pathlib import Path
from vunit import VUnit

import sys
import os

sys.path.append("../")

from scripts.synth_and_test.generate_angles import generate_angle
from scripts.synth_and_test.tb_iterator import tb_iterator


# ============================================================
def encode(config: dict) -> str:
    return ", ".join(["%s:%s" % (key, str(config[key])) for key in config])


# ============================================================
# Setup

VU = VUnit.from_argv(compile_builtins=False)
VU.add_vhdl_builtins()
VU.add_json4vhdl()

# Enable location preprocessing but exclude all but check_false to make the example less bloated
VU.enable_location_preprocessing(
    exclude_subprograms=[
        "debug",
        "info",
        "check",
        "check_failed",
        "check_true",
        "check_implication",
        "check_stable",
        "check_equal",
        "check_not_unknown",
        "check_zero_one_hot",
        "check_one_hot",
        "check_next",
        "check_sequence",
        "check_relation",
    ]
)
VU.enable_check_preprocessing()

# ============================================================
# Directories

# Source directory
src_dir = (Path(__file__).parent / ".." / "src").resolve()

# Testbench directory
tb_dir = (Path(__file__).parent).resolve()

# Waveform .do directory
wave_dir = (Path(__file__).parent / "wave").resolve()

lib = VU.add_library("lib")

# ============================================================
# Add sources
for src_file in src_dir.rglob("*.vhd"):
    lib.add_source_file(src_file)

# ============================================================
# Add testbenches
for tb_file in tb_dir.rglob("tb_*"):
    if tb_file.is_relative_to(tb_dir / "vunit_out"):
        # Skipping vunit_out directory
        continue
    if tb_file.is_relative_to(tb_dir / "wave"):
        # Skipping .do directory
        continue
    lib.add_source_file(tb_file)

# ============================================================
# Add waves
for tb in lib.get_test_benches():
    wave_do = wave_dir / f"{tb.name}.do"
    if wave_do.is_file():
        print(f"- Found existing .do file at: {wave_do}\r")
        tb.set_sim_option("modelsim.init_file.gui", "launch.tcl")
        tb.set_sim_option(
            "modelsim.vsim_flags.gui",
            [
                "-t 1ps",
                "-fsmdebug",
                '-voptargs="+acc"',
                "-coverage",
                "-debugDB",
                "-do",
                f"{{{wave_do.as_posix()}}}",
            ],
        )
    else:
        print(f"- No existing .do file for {tb.name}. Running add_waveforms.tcl\r")
        tb.set_sim_option("modelsim.init_file.gui", "add_waveforms.tcl")
        tb.set_sim_option(
            "modelsim.vsim_flags.gui",
            ["-t 1ps", "-fsmdebug", '-voptargs="+acc"', "-coverage", "-debugDB"],
        )
# ============================================================
# Add test configs

# --------------------
# Reciprocal
# --------------------
G_WIDTH = 32
G_FRAC = 30
G_NBR_OF_ITERATIONS = 30
G_FILEPATH_JSON = Path(f"../scripts/microcodes.json")
G_INIT_FILEPATH_CIRC = Path(f"../data/angle_circ_0_{G_NBR_OF_ITERATIONS - 1}.txt")
G_INIT_FILEPATH_HYPER = Path(f"../data/angle_hyper_0_{G_NBR_OF_ITERATIONS - 1}.txt")
testbench = lib.entity("iterator_tb")

test = testbench.test("auto")
tb_iterator_obj = tb_iterator()
for TYPE in (
    "SIN_COS",  # done
    "ARCTAN",  # done
    "MULT",
    "DIV",
    "RECIPROCAL",
    "SINH_COSH",
    "ARCTANH",
):
    test.add_config(
        name=f"{TYPE}-iter-{G_NBR_OF_ITERATIONS}",
        generics=dict(
            G_TYPE=TYPE,
            G_WIDTH=G_WIDTH,
            G_FRAC=G_FRAC,
            G_NBR_OF_ITERATIONS=G_NBR_OF_ITERATIONS,
            G_FILEPATH_JSON="../../" + str(G_FILEPATH_JSON),
            G_INIT_FILEPATH_CIRC="../../" + str(G_INIT_FILEPATH_CIRC),
            G_INIT_FILEPATH_HYPER="../../" + str(G_INIT_FILEPATH_HYPER),
        ),
        pre_config=tb_iterator_obj.pre_config_wrapper(
            a_full_domain=False,
            a_json_filepath=str(G_FILEPATH_JSON),
            a_type=TYPE,
            a_nbr_of_tests=100,
            a_depth=G_NBR_OF_ITERATIONS,
            a_width=G_WIDTH,
            a_frac=G_FRAC,
            a_output_path_circ=G_INIT_FILEPATH_CIRC,
            a_output_path_hyper=G_INIT_FILEPATH_HYPER,
        ),
        post_check=tb_iterator_obj.post_check_wrapper(a_type=TYPE, a_frac=G_FRAC),
    )

test = testbench.test("manual")
generate_angle_obj = generate_angle()
test.add_config(
    name=f"iter-{G_NBR_OF_ITERATIONS}",
    generics=dict(
        G_NBR_OF_ITERATIONS=G_NBR_OF_ITERATIONS,
        G_FILEPATH_JSON="../../" + str(G_FILEPATH_JSON),
        G_INIT_FILEPATH_CIRC="../../" + str(G_INIT_FILEPATH_CIRC),
        G_INIT_FILEPATH_HYPER="../../" + str(G_INIT_FILEPATH_HYPER),
    ),
    pre_config=generate_angle_obj.pre_config(
        a_depth=G_NBR_OF_ITERATIONS,
        a_width=G_WIDTH,  # this needs to map to what is inside CORDIC pkg
        a_frac=G_FRAC,
        a_output_path_circ=G_INIT_FILEPATH_CIRC,
        a_output_path_hyper=G_INIT_FILEPATH_HYPER,
    ),
)

# ----------------------------
# Another testbench...
# ----------------------------
# And another testbench etc.
# ============================================================

VU.add_compile_option("modelsim.vcom_flags", ["+acc=npr", '+cover="sbcef'])

VU.main()
