#!/usr/bin/env python3

from enum import Enum
from dataclasses import dataclass, field
from collections import defaultdict
from typing import List, Dict, Tuple, Optional, Any
import numpy as np
import math


# TODO
# Implement rest of functions
# Try out new normalization scheme


# --------------------------
# Enums
# --------------------------
class Mode(Enum):
    VECTORING = 0
    ROTATIONAL = 1


class Submode(Enum):
    CIRCULAR = 0
    LINEAR = 1
    HYPERBOLIC = 2


class Init(Enum):
    ZERO = 0
    PROC_GAIN = 1
    PROC_GAIN_HYP = 2
    CONST = 3
    INPUT_X = 4
    INPUT_Y = 5
    INPUT_Z = 6
    OUTPUT_X = 7
    OUTPUT_Y = 8
    OUTPUT_Z = 9
    PROC_GAIN_HYP_INV = 10
    PROC_GAIN_INV = 11


class Function(Enum):
    SIN_COS = 0
    TAN = 1
    ARCSIN = 2
    ARCCOS = 3
    ARCTAN = 4
    POL_TO_REC = 5
    REC_TO_POL = 6
    MULT = 7
    DIV = 8
    RECIPROCAL = 9
    SINH_COSH = 10
    TANH = 11
    ARCTANH = 12
    SQRT = 13
    LN = 14
    EXP = 15
    POW = 16
    SEC = 17
    CSC = 18
    COT = 19
    SECH = 20
    CSCH = 21
    COTH = 22
    ARCSINH = 23
    ARCCOSH = 24


class ShiftType(Enum):
    SINGLE = 1
    DOUBLE = 2


# --------------------------
# Data Classes
# --------------------------
@dataclass
class DataNormalization:
    # Leading Zero Count(normalize by power-of-two)
    norm_enable: bool = False
    norm_inputs: Tuple[str, str, str] = tuple()
    norm_shift: ShiftType = ShiftType.SINGLE
    # Range reduction for z
    reduction_enable: bool = False
    reduction_reconstruct: Optional[bool] = False
    # Map input into primary quadrant [0,pi/2)
    quadrant_enable: bool = False


@dataclass
class MicroStep:
    mode: Mode
    submode: Submode
    init: Dict[str, Tuple[Init, float]] = field(default_factory=dict)
    iter_start: int = 0
    norm_mode: DataNormalization = field(default=DataNormalization)
    comment: str = ""

    def __post_init__(self):
        default_init = {}
        for key, val in self.init.items():
            if len(val) == 1:
                default_init[key] = (val[0], 0.0)
            else:
                default_init[key] = val
        self.init = default_init


@dataclass
class MicrocodeRecord:
    func: Function
    steps: List[MicroStep] = field(default_factory=list)
    comment: str = ""


# --------------------------
# LUT
# --------------------------
# High-level Function LUT keyed by Function
FUNC_REGISTRY: Dict[Function, MicrocodeRecord] = {}


# --------------------------
# Utilities
# --------------------------
def sgn(x: float) -> int:
    return 1 if x >= 0 else -1


def create_step(
    a_mode: Mode,
    a_submode: Submode,
    a_init: Dict[str, Any],
    a_normalization: DataNormalization = DataNormalization(),
    a_iter_start: int = 0,
    a_comment: str = "",
) -> MicroStep:
    return MicroStep(
        mode=a_mode,
        submode=a_submode,
        init=a_init,
        norm_mode=a_normalization,
        iter_start=a_iter_start,
        comment=a_comment,
    )


def register_microcode(a_record: MicrocodeRecord):
    FUNC_REGISTRY[a_record.func] = a_record
    return a_record


def fetch_init_value(
    a_input: str,
    a_step: MicroStep,
    a_x_in: float,
    a_x_prev: float,
    a_y_in: float,
    a_y_prev: float,
    a_z_in: float,
    a_z_prev: float,
) -> float:

    init_tuple = a_step.init.get(str(a_input))

    if init_tuple:
        type = init_tuple[0]
    else:
        return 0.0, 0.0

    if type == Init.PROC_GAIN:
        return 0.60725, 0.0
    elif type == Init.PROC_GAIN_INV:
        return 1 / 0.60725, 0.0
    elif type == Init.PROC_GAIN_HYP:
        return 0.82816, 0.0
    elif type == Init.PROC_GAIN_HYP_INV:
        return 1.0 / 0.82816, 0.0
    elif type == Init.CONST:
        return init_tuple[1], 0.0
    elif type == Init.INPUT_X:
        return a_x_in, init_tuple[1]
    elif type == Init.INPUT_Y:
        return a_y_in, init_tuple[1]
    elif type == Init.INPUT_Z:
        return a_z_in, init_tuple[1]
    elif type == Init.OUTPUT_X:
        return a_x_prev, init_tuple[1]
    elif type == Init.OUTPUT_Y:
        return a_y_prev, init_tuple[1]
    elif type == Init.OUTPUT_Z:
        return a_z_prev, init_tuple[1]
    else:
        raise KeyError("Unknown INIT key!")


def _iter_circular(
    a_mode: Mode, a_x: float, a_y: float, a_z: float, a_iter: int
) -> Tuple[float, float, float]:

    angle = np.arctan(2 ** (-a_iter))
    # print(np.rad2deg(angle))

    if a_mode == Mode.ROTATIONAL:
        d = sgn(a_z)
    else:  # VECTORING
        d = -sgn(a_y) * sgn(a_x)

    x_new = a_x - (a_y * d * (2.0 ** (-a_iter)))
    y_new = a_y + (a_x * d * (2.0 ** (-a_iter)))
    z_new = a_z - (d * angle)
    print(f"Circular: x_old=", a_x, " & x_new=", x_new)
    print(f"Circular: y_old=", a_y, " & y_new=", y_new)
    print(f"Circular: z_old=", a_z, " & z_new=", z_new, " & alfa=", angle)
    print()

    return x_new, y_new, z_new


def _iter_linear(
    a_mode: Mode, a_x: float, a_y: float, a_z: float, a_iter: int
) -> Tuple[float, float, float]:

    angle = 2.0 ** (-a_iter)

    if a_mode == Mode.ROTATIONAL:
        d = sgn(a_z)
    else:  # VECTORING
        d = -sgn(a_y) * sgn(a_x)

    x_new = a_x
    y_new = a_y + ((a_x) * d * ((2.0 ** (-a_iter))))
    z_new = a_z - (d * angle)
    print(f"Linear: x_old=", a_x)
    print(f"Linear: y_old=", a_y, " & y_new=", y_new)
    print(f"Linear: z_old=", a_z, " & z_new=", z_new, " & alfa=", angle)
    print()

    return x_new, y_new, z_new


def _iter_hyperbolic(
    a_mode: Mode, a_x: float, a_y: float, a_z: float, a_iter: int
) -> Tuple[float, float, float]:

    angle = np.arctanh(2 ** (-a_iter))

    if a_mode == Mode.ROTATIONAL:
        d = sgn(a_z)
    else:  # VECTORING
        d = -sgn(a_y)

    x_new = a_x + (a_y * d * ((2.0 ** (-a_iter))))
    y_new = a_y + (a_x * d * ((2.0 ** (-a_iter))))
    z_new = a_z - (d * angle)
    print(f"Hyperbol: x_old=", a_x, " & x_new=", x_new)
    print(f"Hyperbol: y_old=", a_y, " & y_new=", y_new)
    print(f"Hyperbol: z_old=", a_z, " & z_new=", z_new, " & alfa=", angle)
    print()

    return x_new, y_new, z_new


def _LZC(
    a_mode: Mode,
    a_submode: Mode,
    a_shift_inputs: Tuple,
    a_shift_type: ShiftType,
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
    if a_mode == Mode.VECTORING and a_submode != Submode.LINEAR:
        common_shift = max(shift_x, shift_y)
        shift_x = common_shift
        shift_y = common_shift

    # 3. Enforce Even Shifting (Crucial for SQRT)
    if a_shift_type == ShiftType.DOUBLE:
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


def _range_reduction(a_x: float, a_y: float, a_z: float):
    """
    Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
    This variant reduces by integer multiples of ln(2): z = r + n*ln2
    """
    ln2 = math.log(2.0)
    # In FPGA, store log2(e) = 1/ln(2) ~= 1.442695 as a constant
    # ... also store ln(2) of course
    n = int(round(a_z / ln2))
    r = a_z - (n * ln2)
    return a_x, a_y, r, n


def _quadrant_map(a_x: float, a_y: float, a_z: float):
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


def pre_processing(a_step: MicroStep, a_x: float, a_y: float, a_z: float):
    # Default
    shift_x = 0
    shift_y = 0
    shift_z = 0
    quadrant = 1
    range_n = 0

    norm_cfg = a_step.norm_mode
    x_norm, y_norm, z_norm = a_x, a_y, a_z

    if norm_cfg.norm_enable:
        x_norm, y_norm, z_norm, shift_x, shift_y, shift_z = _LZC(
            a_mode=a_step.mode,
            a_submode=a_step.submode,
            a_shift_inputs=norm_cfg.norm_inputs,
            a_shift_type=norm_cfg.norm_shift,
            a_x=x_norm,
            a_y=y_norm,
            a_z=z_norm,
        )
    if norm_cfg.reduction_enable:
        x_norm, y_norm, z_norm, range_n = _range_reduction(
            a_x=x_norm, a_y=y_norm, a_z=z_norm
        )
    if norm_cfg.quadrant_enable:
        x_norm, y_norm, z_norm, quadrant = _quadrant_map(
            a_x=x_norm, a_y=y_norm, a_z=z_norm
        )

    meta = {
        "shift_amount": (int(shift_x), int(shift_y), int(shift_z)),
        "quadrant": int(quadrant),
        "range_n": int(range_n),
    }

    return x_norm, y_norm, z_norm, meta


def post_processing(
    a_step: MicroStep, a_x: float, a_y: float, a_z: float, a_meta: dict
):

    shift_x, shift_y, shift_z = a_meta.get("shift_amount", (0, 0, 0))
    range_n = a_meta.get("range_n", 0)
    quadrant = a_meta.get("quadrant", 1)

    norm_cfg = a_step.norm_mode

    # Default
    x_corr, y_corr, z_corr = a_x, a_y, a_z

    # 1. Handle bit-shift Normalization
    if norm_cfg.norm_enable:

        # Linear: algebraic scaling
        if a_step.submode == Submode.LINEAR:
            if a_step.mode == Mode.ROTATIONAL:
                # MULTIPLICATION: Y = X * Z
                # Reconstruct Y by adding shifts of X and Z
                total_shift = shift_x + shift_z
                x_corr = x_corr * (2**shift_x)
                y_corr = y_corr * (2**total_shift)
                z_corr = z_corr * (2**shift_z)
            else:  # VECTORING
                # DIVISION: Z = Y / X
                # Reconstruct Z by subtracting shifts (Y_shift - X_shift)
                total_shift = shift_y - shift_x
                x_corr = x_corr * (2**shift_x)
                y_corr = y_corr * (2**shift_y)
                z_corr = z_corr * (2**total_shift)

        # Circular/Hyperbolic: geometric scaling
        else:
            if a_step.norm_mode.norm_shift == ShiftType.DOUBLE:
                # Note: this is only really applicable to Mode.VECTORING but its w/e atm (just set correct Normalization)
                # Assuming common shift was applied to X
                half_shift = shift_x // 2
                x_corr = x_corr * (2**half_shift)
                y_corr = y_corr * (2**half_shift)
            else:
                # Standard vector scaling (need uniform scaling of X,Y)
                x_corr = x_corr * (2**shift_x)
                y_corr = y_corr * (2**shift_y)

    # 2. Handle Range Reduction
    if norm_cfg.reduction_enable:
        if a_step.mode == Mode.VECTORING and a_step.submode == Submode.HYPERBOLIC:
            z_corr = z_corr + 0.5 * math.log(2.0) * shift_x
        else:
            ln2 = math.log(2.0)
            z_corr = z_corr + (range_n * ln2)
            if norm_cfg.reduction_reconstruct:
                e_pos_r = x_corr + y_corr
                e_neg_r = x_corr - y_corr
                e_pos_z = (2**range_n) * e_pos_r
                e_neg_z = (2 ** (-range_n)) * e_neg_r
                x_corr = (e_pos_z + e_neg_z) / 2
                y_corr = (e_pos_z - e_neg_z) / 2

    # 3. Handle Quadrant Mapping
    if norm_cfg.quadrant_enable:
        if quadrant == 2:
            z_corr = math.pi - z_corr
            x_corr = -x_corr
        elif quadrant == 3:
            z_corr = math.pi + z_corr
            x_corr = -x_corr
            y_corr = -y_corr
        elif quadrant == 4:
            z_corr = (2.0 * math.pi) - z_corr
            y_corr = -y_corr

    return x_corr, y_corr, z_corr


def execute_cordic(
    a_func: Function, a_x: float, a_y: float, a_z: float, a_nbr_of_iterations: int
):
    microcode_record: MicrocodeRecord

    # ---------------------
    # Fetch from registry
    # ---------------------
    if FUNC_REGISTRY[a_func]:
        microcode_record = FUNC_REGISTRY[a_func]
    else:
        raise KeyError("No such Func!")

    x_val, y_val, z_val = 0.0, 0.0, 0.0

    # ---------------------
    # Loop over all steps
    # ---------------------
    for step in microcode_record.steps:
        # ---------------------
        # Set init values
        # ---------------------
        x_old, y_old, z_old = x_val, y_val, z_val

        if step.init:
            x_val, x_offset = fetch_init_value(
                a_input="x",
                a_step=step,
                a_x_in=a_x,
                a_x_prev=x_old,
                a_y_in=a_y,
                a_y_prev=y_old,
                a_z_in=a_z,
                a_z_prev=z_old,
            )
            y_val, y_offset = fetch_init_value(
                a_input="y",
                a_step=step,
                a_x_in=a_x,
                a_x_prev=x_old,
                a_y_in=a_y,
                a_y_prev=y_old,
                a_z_in=a_z,
                a_z_prev=z_old,
            )
            z_val, z_offset = fetch_init_value(
                a_input="z",
                a_step=step,
                a_x_in=a_x,
                a_x_prev=x_old,
                a_y_in=a_y,
                a_y_prev=y_old,
                a_z_in=a_z,
                a_z_prev=z_old,
            )
        else:
            raise ValueError("Where's the init values?")

        # ---------------------
        # Pre-Processing
        # ---------------------
        print("raw x=", x_val, " y=", y_val, " z=", z_val)
        x_val, y_val, z_val, meta = pre_processing(
            a_step=step, a_x=x_val, a_y=y_val, a_z=z_val
        )
        print("pre_processed x=", x_val, " y=", y_val, " z=", z_val, "meta = ", meta)

        # ---------------------
        # Add offset
        # ---------------------
        x_val += x_offset
        y_val += y_offset
        z_val += z_offset

        # ---------------------
        # Start iterating
        # ---------------------
        iter = step.iter_start
        iter_stutter = 4
        for _ in range(a_nbr_of_iterations):

            if step.submode == Submode.CIRCULAR:
                x_val, y_val, z_val = _iter_circular(
                    a_mode=step.mode, a_x=x_val, a_y=y_val, a_z=z_val, a_iter=iter
                )
                iter += 1
            elif step.submode == Submode.LINEAR:
                x_val, y_val, z_val = _iter_linear(
                    a_mode=step.mode, a_x=x_val, a_y=y_val, a_z=z_val, a_iter=iter
                )
                iter += 1
            elif step.submode == Submode.HYPERBOLIC:
                x_val, y_val, z_val = _iter_hyperbolic(
                    a_mode=step.mode, a_x=x_val, a_y=y_val, a_z=z_val, a_iter=(iter + 1)
                )
                if (iter + 1) == iter_stutter:  # Stutter handling
                    iter_stutter = (3 * iter_stutter) + 1
                else:
                    iter += 1

        # ---------------------
        # Post-Processing
        # ---------------------
        x_val, y_val, z_val = post_processing(
            a_step=step, a_x=x_val, a_y=y_val, a_z=z_val, a_meta=meta
        )

    return x_val, y_val, z_val


if __name__ == "__main__":
    print("Hello world!\n")
