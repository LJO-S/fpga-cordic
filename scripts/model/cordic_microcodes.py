#!/usr/bin/env python3

from cordic_core import (
    Mode,
    Submode,
    Init,
    Function,
    MicroStep,
    MicrocodeRecord,
    DataNormalization,
    ShiftType,
    create_step,
    register_microcode,
)


microcode: MicrocodeRecord
# ------------ SIN_COS ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="Sine & Cosine step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.SIN_COS, steps=steps, comment="Sine/Cosine")
register_microcode(a_record=microcode)

# ------------ TAN ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="TAN step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_X,), "y": (Init.OUTPUT_Y,), "z": (Init.CONST, 0.0)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="Tan step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.TAN, steps=steps, comment="Tan")
register_microcode(a_record=microcode)

# ------------ ARCTAN ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.INPUT_X,), "y": (Init.INPUT_Y,), "z": (Init.CONST, 0.0)},
        a_comment="Arctan step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCTAN, steps=steps, comment="ARCTAN")
register_microcode(a_record=microcode)

# ------------ POL TO REC ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="Pol2rec step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.POL_TO_REC, steps=steps, comment="POL2REC")
register_microcode(a_record=microcode)

# ------------ REC TO POL ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.INPUT_X,), "y": (Init.INPUT_Y,), "z": (Init.CONST, 0.0)},
        a_comment="Rec2pol step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.REC_TO_POL, steps=steps, comment="REC2POL")
register_microcode(a_record=microcode)

# ------------ MULTIPLICATION ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.INPUT_X,), "y": (Init.INPUT_Y,), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "z")),
        a_comment="Mult step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.MULT, steps=steps, comment="MULT")
register_microcode(a_record=microcode)

# ------------ DIVISION ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.INPUT_X,), "y": (Init.INPUT_Y,), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="Div step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.DIV, steps=steps, comment="DIV")
register_microcode(a_record=microcode)

# ------------ RECIPROCAL ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.INPUT_X,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="Reciprocal step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.RECIPROCAL, steps=steps, comment="RECIPROCAL")
register_microcode(a_record=microcode)

# ------------ SINH_COSH ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.CONST, 0.0),
            "z": (Init.INPUT_Z,),
        },
        a_normalization=DataNormalization(
            reduction_enable=True, reduction_reconstruct=True
        ),
        a_comment="SINH_COSH step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.SINH_COSH, steps=steps, comment="SINH_COSH")
register_microcode(a_record=microcode)

# ------------ TANH ----------------

steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.CONST, 0.0),
            "z": (Init.INPUT_Z,),
        },
        a_normalization=DataNormalization(
            reduction_enable=True, reduction_reconstruct=True
        ),
        a_comment="TANH step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.OUTPUT_X,),
            "y": (Init.OUTPUT_Y,),
            "z": (Init.CONST, 0.0),
        },
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="TANH step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.TANH, steps=steps, comment="TANH")
register_microcode(a_record=microcode)

# ------------ ARCTANH ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_X,),
            "y": (Init.INPUT_Y,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCTANH step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCTANH, steps=steps, comment="ARCTANH")
register_microcode(a_record=microcode)

# ------------ SQRT ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_X, 1 / (4 * (0.82816**2))),
            "y": (Init.INPUT_Y, -1 / (4 * (0.82816**2))),
            "z": (Init.CONST, 0.0),
        },
        a_normalization=DataNormalization(
            norm_enable=True,
            norm_inputs=("x", "y"),
            norm_shift=ShiftType.DOUBLE,
            reduction_enable=True,
        ),
        a_comment="SQRT step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.SQRT, steps=steps, comment="SQRT")
register_microcode(a_record=microcode)

# ------------ LN ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_X, 1.0),
            "y": (Init.INPUT_Y, -1.0),
            "z": (Init.CONST, 0.0),
        },
        a_normalization=DataNormalization(
            norm_enable=True,
            norm_inputs=("x", "y"),
            reduction_enable=True,
        ),
        a_comment="LN step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.CONST, 0.5),
            "y": (Init.OUTPUT_Z,),
            "z": (Init.CONST, 0.0),
        },
        a_normalization=DataNormalization(
            norm_enable=True,
            norm_inputs=("x", "y"),
            reduction_enable=False,
        ),
        a_comment="LN step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.LN, steps=steps, comment="LN")
register_microcode(a_record=microcode)

# ------------ EXP  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.PROC_GAIN_HYP_INV,),
            "z": (Init.INPUT_Z,),
        },
        a_normalization=DataNormalization(
            norm_enable=False,
            norm_inputs=("x", "y"),
            reduction_enable=True,
            reduction_reconstruct=True,
        ),
        a_comment="EXP step 1/1",
    ),
]
microcode = MicrocodeRecord(func=Function.EXP, steps=steps, comment="EXP")
register_microcode(a_record=microcode)

# ------------ POW  ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_X, 1.0),
            "y": (Init.INPUT_Y, -1.0),
            "z": (Init.CONST, 0.0),
        },
        a_normalization=DataNormalization(
            norm_enable=True,
            norm_inputs=("x", "y"),
            reduction_enable=True,
        ),
        a_comment="POW step 1/3",
    ),
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.INPUT_Z,),
            "y": (Init.CONST, 0.0),
            "z": (Init.OUTPUT_Z,),
        },
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "z")),
        a_comment="POW step 2/3 (note: Z needs to be 2x the required value)",
    ),
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.PROC_GAIN_HYP_INV,),
            "z": (Init.OUTPUT_Y,),
        },
        a_normalization=DataNormalization(
            norm_enable=False,
            norm_inputs=("x", "y"),
            reduction_enable=True,
            reduction_reconstruct=True,
        ),
        a_comment="POW step 3/3",
    ),
]
microcode = MicrocodeRecord(func=Function.POW, steps=steps, comment="POW")
register_microcode(a_record=microcode)

# ------------ ARCCOSH  ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_X,),
            "y": (Init.CONST, 1.0),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCCOSH step 1/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.PROC_GAIN_HYP,),
            "y": (Init.OUTPUT_X,),
            "z": (Init.INPUT_X,),
        },
        a_comment="ARCCOSH step 2/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.OUTPUT_Z, 1.0),
            "y": (Init.OUTPUT_Z, -1.0),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCCOSH step 3/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.CONST, 0.5),
            "y": (Init.OUTPUT_Z,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCCOSH step 4/4",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCCOSH, steps=steps, comment="ARCCOSH")
register_microcode(a_record=microcode)
# ------------ ARCSINH  ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.CIRCULAR,
        a_init={
            "x": (Init.CONST, 1.0),
            "y": (Init.INPUT_Y,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCSINH step 1/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.PROC_GAIN_INV,),
            "y": (Init.OUTPUT_X,),
            "z": (Init.INPUT_Y,),
        },
        a_comment="ARCSINH step 2/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.OUTPUT_Z, 1.0),
            "y": (Init.OUTPUT_Z, -1.0),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCSINH step 3/4",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.CONST, 0.5),
            "y": (Init.OUTPUT_Z,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCSINH step 4/4",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCSINH, steps=steps, comment="ARCSINH")
register_microcode(a_record=microcode)

# ------------ CSC  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="CSC step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_X,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="CSC step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.CSC, steps=steps, comment="CSC")
register_microcode(a_record=microcode)

# ------------ SEC  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="SEC step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_Y,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="SEC step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.SEC, steps=steps, comment="SEC")
register_microcode(a_record=microcode)

# ------------ COT  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.CIRCULAR,
        a_init={"x": (Init.PROC_GAIN,), "y": (Init.CONST, 0.0), "z": (Init.INPUT_Z,)},
        a_normalization=DataNormalization(quadrant_enable=True),
        a_comment="COT step 1/3",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_X,), "y": (Init.OUTPUT_Y,), "z": (Init.CONST, 0.0)},
        # a_iter_start=-2,
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="COT step 2/3",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_Z,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_normalization=DataNormalization(norm_enable=True, norm_inputs=("x", "y")),
        a_comment="COT step 3/3",
    ),
]
microcode = MicrocodeRecord(func=Function.COT, steps=steps, comment="COT")
register_microcode(a_record=microcode)

# ------------ SECH  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.CONST, 0.0),
            "z": (Init.INPUT_Z,),
        },
        a_comment="SECH step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_X,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_comment="SECH step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.SECH, steps=steps, comment="SECH")
register_microcode(a_record=microcode)

# ------------ CSCH  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.CONST, 0.0),
            "z": (Init.INPUT_Z,),
        },
        a_comment="SECH step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_Y,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_comment="CSCH step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.CSCH, steps=steps, comment="CSCH")
register_microcode(a_record=microcode)

# ------------ COTH  ----------------
steps = [
    create_step(
        a_mode=Mode.ROTATIONAL,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.PROC_GAIN_HYP_INV,),
            "y": (Init.CONST, 0.0),
            "z": (Init.INPUT_Z,),
        },
        a_comment="COTH step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={
            "x": (Init.OUTPUT_X,),
            "y": (Init.OUTPUT_Y,),
            "z": (Init.OUTPUT_Z,),
        },
        a_comment="COTH step 2/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.LINEAR,
        a_init={"x": (Init.OUTPUT_Z,), "y": (Init.CONST, 1.0), "z": (Init.CONST, 0.0)},
        a_comment="COTH step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.COTH, steps=steps, comment="COTH")
register_microcode(a_record=microcode)

# ------------ ARCSIN ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_Y, 1 / (4 * (0.82816**2))),
            "y": (Init.INPUT_Y, -1 / (4 * (0.82816**2))),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCSIN step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.CIRCULAR,
        a_init={
            "x": (Init.OUTPUT_X,),
            "y": (Init.INPUT_X,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCSIN step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCSIN, steps=steps, comment="ARCSIN")
register_microcode(a_record=microcode)

# ------------ ARCCOS ----------------
steps = [
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.HYPERBOLIC,
        a_init={
            "x": (Init.INPUT_Y, 1 / (4 * (0.82816**2))),
            "y": (Init.INPUT_Y, -1 / (4 * (0.82816**2))),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCCOS step 1/2",
    ),
    create_step(
        a_mode=Mode.VECTORING,
        a_submode=Submode.CIRCULAR,
        a_init={
            "x": (Init.INPUT_X,),
            "y": (Init.OUTPUT_X,),
            "z": (Init.CONST, 0.0),
        },
        a_comment="ARCCOS step 2/2",
    ),
]
microcode = MicrocodeRecord(func=Function.ARCCOS, steps=steps, comment="ARCCOS")
register_microcode(a_record=microcode)
