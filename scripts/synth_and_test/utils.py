import numpy as np
import random
import json
import math
from pathlib import Path

random.seed(10)

AN = 0.60725
AN_HYP = 0.82816


def read_json(filename: str):
    """
    Read a JSON file and return an object

    :param filename: The name of the file to read

    :example:

    .. code-block:: python

       generics = read_json(join(root, "src/test/data/data.json"))
    """
    with Path(filename).open("r", encoding="utf-8") as fptr:
        return json.loads(fptr.read())


def generate_input_data(
    a_json_obj: any, a_type: str, a_full_domain: bool, a_width: int = 4
):

    # Always use 1st microcode step
    entry = a_json_obj[a_type][0]
    print(entry)

    x, y, z = 0.0, 0.0, 0.0
    if a_type.upper() == "SIN_COS":
        x = fetch_init_value(entry["init"]["x"]["type"])
        y = fetch_init_value(entry["init"]["y"]["type"])
        if a_full_domain is True:
            z = random.uniform(0, 2 * np.pi)
        else:
            z = random.uniform(0, np.deg2rad(45))
    elif a_type.upper() == "ARCTAN":
        x = random.uniform(0, 1)
        z = 0.0
        if a_full_domain is True:
            y = random.uniform(0, 10)
        else:
            y = random.uniform(0, 1)
    elif a_type.upper() == "MULT":
        y = 0.0
        if a_full_domain is True:
            x = random.uniform(0, 2 ** (a_width - 1) - 1)
            z = random.uniform(0, 2 ** (a_width - 1) - 1)
        else:
            x = random.uniform(0, 1)
            z = random.uniform(0, 1)
    elif a_type.upper() == "DIV":
        z = 0.0
        if a_full_domain is True:
            x = random.uniform(0, 2 ** (a_width - 1) - 1)
            y = random.uniform(0, 2 ** (a_width - 1) - 1)
        else:
            x = random.uniform(0, 1)
            y = random.uniform(0, x)
    elif a_type.upper() == "RECIPROCAL":
        y = 0.0
        z = 0.0
        if a_full_domain is True:
            x = random.uniform(0.1, 2 ** (a_width - 1) - 1)
        else:
            x = random.uniform(0.5, 1)
    elif a_type.upper() == "SINH_COSH":
        x = fetch_init_value(entry["init"]["x"]["type"])
        y = 0.0
        if a_full_domain is True:
            # Note: for SINH_COSH the Z represents exp(Z). We use N later to
            # shift everything to a correct value. The integer width decides
            # how much we can shift it. Thus, the largest Z is decided by how
            # many integer bits we have available times ln(2).
            z = random.uniform(0, math.log(2) * (a_width - 1))
        else:
            z = random.uniform(0, 1)
    elif a_type.upper() == "ARCTANH":
        x = random.uniform(0, 0.1)
        y = x / 2
        z = 0.0
    else:
        pass
    return (
        x + entry["init"]["x"]["offset"],
        y + entry["init"]["y"]["offset"],
        z + entry["init"]["z"]["offset"],
    )


def generete_reference_data(a_type: str, x: float, y: float, z: float):

    x_exp, y_exp, z_exp = 0.0, 0.0, 0.0
    if a_type.upper() == "SIN_COS":
        # Expected
        x_exp = np.cos(z)
        y_exp = np.sin(z)
        z_exp = None
    elif a_type.upper() == "ARCTAN":
        x_exp = (1 / AN) * np.sqrt((x**2) + (y**2))
        y_exp = None
        z_exp = np.arctan(y / x)
    elif a_type.upper() == "MULT":
        x_exp = x
        y_exp = y + (x * z)
        z_exp = None
    elif a_type.upper() == "DIV":
        x_exp = x
        y_exp = None
        z_exp = z + (y / x)
    elif a_type.upper() == "RECIPROCAL":
        x_exp = x
        y_exp = None
        z_exp = z + (1 / x)
    elif a_type.upper() == "SINH_COSH":
        x_exp = np.cosh(z)
        y_exp = np.sinh(z)
        z_exp = None
    elif a_type.upper() == "ARCTANH":
        x_exp = AN_HYP * np.sqrt((x**2) - (y**2))
        y_exp = None
        z_exp = z + np.arctanh(y / x)
    else:
        pass
    return x_exp, y_exp, z_exp


def fetch_init_value(
    a_init_type: str,
) -> float:
    if a_init_type == "PROC_GAIN":
        return 0.60725
    elif a_init_type == "PROC_GAIN_INV":
        return 1 / 0.60725
    elif a_init_type == "PROC_GAIN_HYP":
        return 0.82816
    elif a_init_type == "PROC_GAIN_HYP_INV":
        return 1.0 / 0.82816
    else:
        return 0.0


def LZC(
    a_shift_common: bool,
    a_shift_inputs: tuple,
    a_shift_double: bool,
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
    if a_shift_common:
        common_shift = max(shift_x, shift_y)
        shift_x = common_shift
        shift_y = common_shift

    # 3. Enforce Even Shifting (Crucial for SQRT)
    if a_shift_double:
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


def anti_LZC(
    a_mode_rotational: bool,
    a_submode_linear: bool,
    a_shift_double: bool,
    a_x: float,
    a_y: float,
    a_z: float,
    a_x_shift: int,
    a_y_shift: int,
    a_z_shift: int,
):
    """
    De-Normalize (x,y) by shifting so that abs(x) is in [1,2) (or similar)
    """
    x_corr = a_x
    y_corr = a_y
    z_corr = a_z
    # Linear: algebraic scaling
    if a_submode_linear is True:
        if a_mode_rotational is True:
            # MULTIPLICATION: Y = X * Z
            # Reconstruct Y by adding shifts of X and Z
            total_shift = a_x_shift + a_z_shift
            x_corr = x_corr * (2**a_x_shift)
            y_corr = y_corr * (2**total_shift)
            z_corr = z_corr * (2**a_z_shift)
        else:  # VECTORING
            # DIVISION: Z = Y / X
            # Reconstruct Z by subtracting shifts (Y_shift - X_shift)
            total_shift = a_y_shift - a_x_shift
            x_corr = x_corr * (2**a_x_shift)
            y_corr = y_corr * (2**a_y_shift)
            z_corr = z_corr * (2**total_shift)

    # Circular/Hyperbolic: geometric scaling
    else:
        if a_shift_double is True:
            # Note: this is only really applicable to Mode.VECTORING but its w/e atm (just set correct Normalization)
            # Assuming common shift was applied to X
            half_shift = a_x_shift // 2
            x_corr = x_corr * (2**half_shift)
            y_corr = y_corr * (2**half_shift)
        else:
            # Standard vector scaling (need uniform scaling of X,Y)
            x_corr = x_corr * (2**a_x_shift)
            y_corr = y_corr * (2**a_y_shift)

    return x_corr, y_corr, z_corr


def quadrant_map(a_x: float, a_y: float, a_z: float):
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


def anti_quadrant_map(a_x: float, a_y: float, a_z: float, a_quadrant: int):
    """
    De-Map angle z
    """
    x_corr, y_corr, z_corr = a_x, a_y, a_z
    if a_quadrant == 2:
        z_corr = math.pi - z_corr
        x_corr = -x_corr
    elif a_quadrant == 3:
        z_corr = math.pi + z_corr
        x_corr = -x_corr
        y_corr = -y_corr
    elif a_quadrant == 4:
        z_corr = (2.0 * math.pi) - z_corr
        y_corr = -y_corr

    return x_corr, y_corr, z_corr


def range_reduction(a_x: float, a_y: float, a_z: float):
    """
    Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
    This variant reduces by integer multiples of ln(2): z = r + n*ln2
    """
    ln2 = math.log(2.0)
    # In FPGA, store log2(e) = 1/ln(2) ~= 1.442695 as a constant
    # ... also store ln(2) of course
    n = int(math.floor(a_z / ln2))
    r = a_z - (n * ln2)
    return a_x, a_y, r, n


def anti_range_reduction(
    a_mode_vectoring: bool,
    a_submode_hyperbolic: bool,
    a_reduction_reconstruct: bool,
    a_int_width: int,
    a_range_n: int,
    a_shift_x: int,
    a_x: float,
    a_y: float,
    a_z: float,
):
    x_corr, y_corr, z_corr = a_x, a_y, a_z
    if a_mode_vectoring is True and a_submode_hyperbolic is True:
        z_corr = z_corr + 0.5 * math.log(2.0) * a_shift_x
    else:
        ln2 = math.log(2.0)
        z_corr = z_corr + (a_range_n * ln2)
        if a_reduction_reconstruct:
            if abs(a_range_n) > (a_int_width):
                raise ValueError("Too large input value!")
            e_pos_r = x_corr + y_corr
            e_neg_r = x_corr - y_corr
            e_pos_z = e_pos_r * (2**a_range_n)
            e_neg_z = e_neg_r * (2 ** (-a_range_n))
            x_corr = (e_pos_z + e_neg_z) / 2
            y_corr = (e_pos_z - e_neg_z) / 2
    return x_corr, y_corr, z_corr


def compare_value(actual, reference):
    if reference is not None:
        match = math.isclose(a=actual, b=reference, rel_tol=0.001, abs_tol=1e-9)
        diff_rel = abs(actual - reference) / (reference + 1e-9)
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
