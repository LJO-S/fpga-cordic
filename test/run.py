#!/usr/bin/env python3

# ============================================================
from pathlib import Path
from vunit import VUnit

import sys
import os

sys.path.append("../")

from scripts.synth_and_test.generate_angles import generate_angle
from scripts.synth_and_test.tb_iterator import tb_iterator
from scripts.synth_and_test.tb_preproc import *
from scripts.synth_and_test.tb_postproc import *


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
    if "cordic.vhd" in str(src_file):
        continue
    if "microcode_rom.vhd" in str(src_file):
        continue
    if "microcode_rom_wrapper.vhd" in str(src_file):
        continue
    if "cordic_core.vhd" in str(src_file):
        continue
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
# Iterator
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
    "SIN_COS",
    "ARCTAN",
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
            a_nbr_of_tests=1000,
            a_depth=G_NBR_OF_ITERATIONS,
            a_width=G_WIDTH,
            a_frac=G_FRAC,
            a_output_path_circ=G_INIT_FILEPATH_CIRC,
            a_output_path_hyper=G_INIT_FILEPATH_HYPER,
        ),
        post_check=tb_iterator_obj.post_check_wrapper(a_type=TYPE, a_frac=G_FRAC),
    )

# --------------------
# Range Reduce
# --------------------
G_DATA_WIDTH_DENORM = 35
G_DATA_WIDTH_NORM = 32
G_DATA_WIDTH_FRAC = 30
G_RANGE_N_WIDTH = 10
G_FILEPATH_JSON = Path(
    f"../scripts/microcodes.json"
)  # completely unecessary for this test but pre_cfg uses it...

testbench = lib.entity("preproc_range_reduce_tb")
test = testbench.test("auto")
tb_normalizer_obj = tb_normalizer()

test.add_config(
    name=f".",
    generics=dict(
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_DATA_WIDTH_NORM=G_DATA_WIDTH_NORM,
        G_DATA_WIDTH_FRAC=G_DATA_WIDTH_FRAC,
        G_RANGE_N_WIDTH=G_RANGE_N_WIDTH,
    ),
    pre_config=tb_normalizer_obj.pre_config_wrapper(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_type="range_reduce",
        a_nbr_of_tests=1000,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_normalizer_obj.post_check_wrapper_range_reduce(
        a_frac=G_DATA_WIDTH_FRAC
    ),
)


# --------------------
# Bitshift Norm
# --------------------
def shift_input_str_to_slv(a_tuple: tuple) -> int:
    G_SHIFT_INPUTS_slv = 0
    if "x" in a_tuple:
        G_SHIFT_INPUTS_slv += 1
    if "y" in a_tuple:
        G_SHIFT_INPUTS_slv += 10
    if "z" in a_tuple:
        G_SHIFT_INPUTS_slv += 100
    return G_SHIFT_INPUTS_slv


G_DATA_WIDTH_DENORM = 35
G_DATA_WIDTH_NORM = 32
G_SHIFT_COMMON = False
G_SHIFT_DOUBLE = False
G_SHIFT_INPUTS = ("x", "y", "z")

testbench = lib.entity("preproc_bitshift_norm_tb")
test = testbench.test("auto")
tb_normalizer_obj = tb_normalizer()

test.add_config(
    name=f".",
    generics=dict(
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_DATA_WIDTH_NORM=G_DATA_WIDTH_NORM,
        G_SHIFT_INPUTS=111,
        G_SHIFT_DOUBLE=G_SHIFT_DOUBLE,
        G_SHIFT_COMMON=G_SHIFT_COMMON,
    ),
    pre_config=tb_normalizer_obj.pre_config_wrapper(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_type="bitshift_norm",
        a_nbr_of_tests=1000,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_normalizer_obj.post_check_wrapper_bitshift_norm(
        a_frac=G_DATA_WIDTH_FRAC,
        a_shift_common=G_SHIFT_COMMON,
        a_shift_inputs=G_SHIFT_INPUTS,
        a_shift_double=G_SHIFT_DOUBLE,
    ),
)

# --------------------
# Quadrant map
# --------------------
G_DATA_WIDTH_DENORM = 32
G_DATA_WIDTH_NORM = 29
G_DATA_WIDTH_FRAC = 27

testbench = lib.entity("preproc_quadrant_map_tb")
test = testbench.test("auto")
tb_normalizer_obj = tb_normalizer()

test.add_config(
    name=f".",
    generics=dict(
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_DATA_WIDTH_NORM=G_DATA_WIDTH_NORM,
        G_DATA_WIDTH_FRAC=G_DATA_WIDTH_FRAC,
    ),
    pre_config=tb_normalizer_obj.pre_config_wrapper(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_type="quadrant_map",
        a_nbr_of_tests=1000,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_normalizer_obj.post_check_wrapper_quadrant_map(
        a_frac=G_DATA_WIDTH_FRAC,
    ),
)


# --------------------
# Preprocess Wrapper
# --------------------
config = [
    {
        "NAME": "bitshift",
        "TYPE_SLV": "001",
        "G_DATA_WIDTH_DENORM": 32,
        "G_DATA_WIDTH_NORM": 29,
        "G_DATA_WIDTH_FRAC": 27,
        "G_RANGE_N_WIDTH": 10,
        "G_SHIFT_WIDTH": 5,
        "G_SHIFT_COMMON": False,
        "G_SHIFT_DOUBLE": False,
        "G_SHIFT_INPUTS": ("x", "y", "z"),
    },
    {
        "NAME": "quadrant",
        "TYPE_SLV": "100",
        "G_DATA_WIDTH_DENORM": 32,
        "G_DATA_WIDTH_NORM": 29,
        "G_DATA_WIDTH_FRAC": 27,
        "G_RANGE_N_WIDTH": 10,
        "G_SHIFT_WIDTH": 5,
        "G_SHIFT_COMMON": False,
        "G_SHIFT_DOUBLE": False,
        "G_SHIFT_INPUTS": ("x", "y", "z"),
    },
    {
        "NAME": "range",
        "TYPE_SLV": "010",
        "G_DATA_WIDTH_DENORM": 32,
        "G_DATA_WIDTH_NORM": 29,
        "G_DATA_WIDTH_FRAC": 27,
        "G_RANGE_N_WIDTH": 10,
        "G_SHIFT_WIDTH": 5,
        "G_SHIFT_COMMON": False,
        "G_SHIFT_DOUBLE": False,
        "G_SHIFT_INPUTS": ("x", "y", "z"),
    },
    {
        "NAME": "bitshift-and-range",
        "TYPE_SLV": "011",
        "G_DATA_WIDTH_DENORM": 32,
        "G_DATA_WIDTH_NORM": 29,
        "G_DATA_WIDTH_FRAC": 27,
        "G_RANGE_N_WIDTH": 10,
        "G_SHIFT_WIDTH": 5,
        "G_SHIFT_COMMON": False,
        "G_SHIFT_DOUBLE": False,
        "G_SHIFT_INPUTS": ("x", "y", "z"),
    },
]


testbench = lib.entity("cordic_preprocess_tb")
test = testbench.test("auto")
tb_preproc_checker_obj = preproc_checker()
for cfg in config:
    test.add_config(
        name=f'TYPE={cfg["NAME"]}_DW={cfg["G_DATA_WIDTH_DENORM"]}_W={cfg["G_DATA_WIDTH_NORM"]}_F={cfg["G_DATA_WIDTH_FRAC"]}_S={cfg["G_SHIFT_WIDTH"]}_R={cfg["G_RANGE_N_WIDTH"]}_C={cfg["G_SHIFT_COMMON"]}_D={cfg["G_SHIFT_DOUBLE"]}_I={shift_input_str_to_slv(cfg["G_SHIFT_INPUTS"])}',
        generics=dict(
            G_DATA_WIDTH_DENORM=cfg["G_DATA_WIDTH_DENORM"],
            G_DATA_WIDTH_NORM=cfg["G_DATA_WIDTH_NORM"],
            G_DATA_WIDTH_FRAC=cfg["G_DATA_WIDTH_FRAC"],
            G_SHIFT_WIDTH=cfg["G_SHIFT_WIDTH"],
            G_RANGE_N_WIDTH=cfg["G_RANGE_N_WIDTH"],
            G_SHIFT_COMMON=cfg["G_SHIFT_COMMON"],
            G_SHIFT_DOUBLE=cfg["G_SHIFT_DOUBLE"],
            G_SHIFT_INPUTS=shift_input_str_to_slv(cfg["G_SHIFT_INPUTS"]),
            G_NORM_TYPE=int(cfg["TYPE_SLV"]),
        ),
        pre_config=tb_preproc_checker_obj.pre_config_wrapper(
            a_json_filepath=str(G_FILEPATH_JSON),
            a_type_slv=cfg["TYPE_SLV"],
            a_nbr_of_tests=1000,
            a_data_width_denorm=cfg["G_DATA_WIDTH_DENORM"],
            a_data_width_frac=cfg["G_DATA_WIDTH_FRAC"],
        ),
        post_check=tb_preproc_checker_obj.post_check_wrapper(a_cfg=cfg),
    )

# --------------------
# Post-process Bitshift
# --------------------
testbench = lib.entity("postproc_bitshift_tb")
test = testbench.test("auto")
tb_postproc_checker_obj = postproc_checker()

G_DATA_WIDTH_DENORM = 32
G_DATA_WIDTH_FRAC = 23
G_SHIFT_WIDTH = 5
G_MODE_ROTATIONAL = False
G_SUBMODE_LINEAR = False
G_SHIFT_DOUBLE = False

test.add_config(
    name=f"geometric-standard",
    generics=dict(
        G_MODE_ROTATIONAL=G_MODE_ROTATIONAL,
        G_SUBMODE_LINEAR=G_SUBMODE_LINEAR,
        G_SHIFT_DOUBLE=G_SHIFT_DOUBLE,
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_SHIFT_WIDTH=G_SHIFT_WIDTH,
    ),
    pre_config=tb_postproc_checker_obj.pre_config_wrapper_bitshift(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_nbr_of_tests=1000,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_postproc_checker_obj.post_check_wrapper_bitshift(
        a_mode_rotational=G_MODE_ROTATIONAL,
        a_submode_linear=G_SUBMODE_LINEAR,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
)
G_SHIFT_DOUBLE = True
test.add_config(
    name=f"geometric-double",
    generics=dict(
        G_MODE_ROTATIONAL=G_MODE_ROTATIONAL,
        G_SUBMODE_LINEAR=G_SUBMODE_LINEAR,
        G_SHIFT_DOUBLE=G_SHIFT_DOUBLE,
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_SHIFT_WIDTH=G_SHIFT_WIDTH,
    ),
    pre_config=tb_postproc_checker_obj.pre_config_wrapper_bitshift(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_nbr_of_tests=1000,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_postproc_checker_obj.post_check_wrapper_bitshift(
        a_mode_rotational=G_MODE_ROTATIONAL,
        a_submode_linear=G_SUBMODE_LINEAR,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
)

G_SUBMODE_LINEAR = True
G_MODE_ROTATIONAL = False
test.add_config(
    name=f"algebraic-vectoring",
    generics=dict(
        G_MODE_ROTATIONAL=G_MODE_ROTATIONAL,
        G_SUBMODE_LINEAR=G_SUBMODE_LINEAR,
        G_SHIFT_DOUBLE=G_SHIFT_DOUBLE,
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_SHIFT_WIDTH=G_SHIFT_WIDTH,
    ),
    pre_config=tb_postproc_checker_obj.pre_config_wrapper_bitshift(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_nbr_of_tests=1000,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_postproc_checker_obj.post_check_wrapper_bitshift(
        a_mode_rotational=G_MODE_ROTATIONAL,
        a_submode_linear=G_SUBMODE_LINEAR,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
)
G_SUBMODE_LINEAR = True
G_MODE_ROTATIONAL = True
test.add_config(
    name=f"algebraic-rotational",
    generics=dict(
        G_MODE_ROTATIONAL=G_MODE_ROTATIONAL,
        G_SUBMODE_LINEAR=G_SUBMODE_LINEAR,
        G_SHIFT_DOUBLE=G_SHIFT_DOUBLE,
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_SHIFT_WIDTH=G_SHIFT_WIDTH,
    ),
    pre_config=tb_postproc_checker_obj.pre_config_wrapper_bitshift(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_nbr_of_tests=1000,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_postproc_checker_obj.post_check_wrapper_bitshift(
        a_mode_rotational=G_MODE_ROTATIONAL,
        a_submode_linear=G_SUBMODE_LINEAR,
        a_shift_double=G_SHIFT_DOUBLE,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
)

# --------------------
# Post-process Quadrant Map
# --------------------
testbench = lib.entity("postproc_quadrant_map_tb")
test = testbench.test("auto")
tb_postproc_checker_obj = postproc_checker()

G_DATA_WIDTH_DENORM = 32
G_DATA_WIDTH_FRAC = 23
test.add_config(
    name=f".",
    generics=dict(
        G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
        G_DATA_WIDTH_FRAC=G_DATA_WIDTH_FRAC,
    ),
    pre_config=tb_postproc_checker_obj.pre_config_wrapper_quadrant_map(
        a_json_filepath=str(G_FILEPATH_JSON),
        a_nbr_of_tests=1000,
        a_data_width_denorm=G_DATA_WIDTH_DENORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
    post_check=tb_postproc_checker_obj.post_check_wrapper_quadrant_map(
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    ),
)

# --------------------
# Post-process Range Reduction
# --------------------
testbench = lib.entity("postproc_range_reduce_tb")
test = testbench.test("auto")
tb_postproc_checker_obj = postproc_checker()

G_DATA_WIDTH_DENORM = 32
G_DATA_WIDTH_FRAC = 23
G_RANGE_N_WIDTH = 10
G_SHIFT_WIDTH = 5

config = [
    {
        "NAME": "normal-non-reconstructive",
        "G_MODE_VECTORING": False,
        "G_SUBMODE_HYPERBOLIC": False,
        "G_REDUCTION_RECONSTRUCT": False,
    },
    {
        "NAME": "special",
        "G_MODE_VECTORING": True,
        "G_SUBMODE_HYPERBOLIC": True,
        "G_REDUCTION_RECONSTRUCT": False,
    },
    {
        "NAME": "special-not-fulfilled_A",
        "G_MODE_VECTORING": True,
        "G_SUBMODE_HYPERBOLIC": False,
        "G_REDUCTION_RECONSTRUCT": False,
    },
    {
        "NAME": "special-not-fulfilled_B",
        "G_MODE_VECTORING": False,
        "G_SUBMODE_HYPERBOLIC": True,
        "G_REDUCTION_RECONSTRUCT": False,
    },
    {
        "NAME": "normal-reconstructive",
        "G_MODE_VECTORING": False,
        "G_SUBMODE_HYPERBOLIC": False,
        "G_REDUCTION_RECONSTRUCT": True,
    },
]

tb_postproc_checker_obj = postproc_checker()

for cfg in config:
    test.add_config(
        name=f"{cfg["NAME"]}",
        generics=dict(
            G_MODE_VECTORING=cfg["G_MODE_VECTORING"],
            G_SUBMODE_HYPERBOLIC=cfg["G_SUBMODE_HYPERBOLIC"],
            G_REDUCTION_RECONSTRUCT=cfg["G_REDUCTION_RECONSTRUCT"],
            G_DATA_WIDTH_DENORM=G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_FRAC=G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH=G_SHIFT_WIDTH,
            G_RANGE_N_WIDTH=G_RANGE_N_WIDTH,
        ),
        pre_config=tb_postproc_checker_obj.pre_config_wrapper_range_reduce(
            a_json_filepath=str(G_FILEPATH_JSON),
            a_nbr_of_tests=1000,
            a_data_width_denorm=G_DATA_WIDTH_DENORM,
            a_data_width_frac=G_DATA_WIDTH_FRAC,
        ),
        post_check=tb_postproc_checker_obj.post_check_wrapper_range_reduce(
            a_mode_vectoring=cfg["G_MODE_VECTORING"],
            a_submode_hyperbolic=cfg["G_SUBMODE_HYPERBOLIC"],
            a_reduction_reconstruct=cfg["G_REDUCTION_RECONSTRUCT"],
            a_data_width_denorm=G_DATA_WIDTH_DENORM,
            a_data_width_frac=G_DATA_WIDTH_FRAC,
        ),
    )

# --------------------
# Post-Process
# --------------------
testbench = lib.entity("cordic_postprocess_tb")
test = testbench.test("auto")
tb_postproc_checker_obj = postproc_checker()

G_DATA_WIDTH_DENORM = 32
G_DATA_WIDTH_NORM = 25
G_DATA_WIDTH_FRAC = 23
G_SHIFT_WIDTH = int(math.log2(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM))
G_RANGE_N_WIDTH = 10

default_dict = dict(
    name="0",
    norm_en="0",
    norm_input="000",
    norm_shift_double="0",
    reduction_en="0",
    reduction_reconstruct="0",
    quadrant_en="0",
    G_MODE="0",
    G_SUBMODE="0",
    G_DATA_WIDTH_DENORM="32",
    G_DATA_WIDTH_NORM="25",
    G_DATA_WIDTH_FRAC="25",
    G_SHIFT_WIDTH=str(int(math.log2(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM))),
    G_RANGE_N_WIDTH="10",
)

case_dict = [
    dict(
        name="none",
    ),
    dict(
        name="norm",
        norm_en="1",
    ),
    dict(
        name="norm-double",
        norm_en="1",
        norm_shift_double="1",
    ),
    dict(
        name="range_reduce",
        reduction_en="1",
    ),
    dict(
        name="range_reduce-reconstruct",
        reduction_en="1",
        reduction_reconstruct="1",
    ),
    dict(
        name="quadrant_map",
        quadrant_en="1",
    ),
]
# TODO add specials

tb_postproc_checker_obj = postproc_checker()

for override in case_dict:

    cfg = {**default_dict, **override}

    test.add_config(
        name=f"{cfg["name"]}",
        generics=dict(encoded_tb_cfg=encode(cfg)),
        pre_config=tb_postproc_checker_obj.pre_config_wrapper_range_reduce(
            a_json_filepath=str(G_FILEPATH_JSON),
            a_nbr_of_tests=1000,
            a_data_width_denorm=cfg["G_DATA_WIDTH_DENORM"],
            a_data_width_frac=cfg["G_DATA_WIDTH_FRAC"],
        ),
        post_check=tb_postproc_checker_obj.post_check_wrapper_range_reduce(
            a_mode_vectoring=cfg["G_MODE_VECTORING"],
            a_submode_hyperbolic=cfg["G_SUBMODE_HYPERBOLIC"],
            a_reduction_reconstruct=cfg["G_REDUCTION_RECONSTRUCT"],
            a_data_width_denorm=G_DATA_WIDTH_DENORM,
            a_data_width_frac=G_DATA_WIDTH_FRAC,
        ),
    )
# And another testbench etc.
# ============================================================

VU.add_compile_option("modelsim.vcom_flags", ["+acc=npr", '+cover="sbcef'])

VU.main()
