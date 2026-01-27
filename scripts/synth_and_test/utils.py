import numpy as np
import random
import json
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


def generate_input_data(a_json_obj: any, a_type: str, a_full_domain: bool, a_iter: int):

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
            x = random.uniform(0, 100)
            z = random.uniform(0, 100)
        else:
            x = random.uniform(0, 1)
            z = random.uniform(0, 1)
    elif a_type.upper() == "DIV":
        z = 0.0
        if a_full_domain is True:
            x = random.uniform(0, 100)
            y = random.uniform(0, 100)
        else:
            x = random.uniform(0, 1)
            y = random.uniform(0, x)
    elif a_type.upper() == "RECIPROCAL":
        y = 0.0
        z = 0.0
        if a_full_domain is True:
            x = random.uniform(0.1, 100)
        else:
            x = random.uniform(0.5, 1)
    elif a_type.upper() == "SINH_COSH":
        x = fetch_init_value(entry["init"]["x"]["type"])
        y = 0.0
        if a_full_domain is True:
            z = random.uniform(0, 100)
        else:
            z = random.uniform(0, 1)
    elif a_type.upper() == "ARCTANH":
        x = random.uniform(0, 0.1)
        # y = random.uniform(0, x)
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
