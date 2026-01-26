#!/usr/bin/env python3

import numpy as np
import random

from cordic_core import execute_cordic, Function
import cordic_microcodes

AN = 0.60725
AN_HYP = 0.82816


def print_results(a_title, a_x, a_y, a_z):
    print(f"{a_title.upper()} Results:\n x={a_x} \n y={a_y} \n z={a_z}")


def test_function(a_func: Function):

    x, y, z = 0.0, 0.0, 0.0
    x_exp, y_exp, z_exp = 0.0, 0.0, 0.0

    if a_func == Function.SIN_COS:
        # Input
        x = 0.0
        y = 0.0
        # z = random.uniform(0, 2 * np.pi)
        z = np.deg2rad(45)
        # Expected
        x_exp = np.cos(z)
        y_exp = np.sin(z)
        z_exp = None
    elif a_func == Function.TAN:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(0, 2 * np.pi)
        # Expected
        x_exp = np.cos(z)
        y_exp = None
        z_exp = np.tan(z)
    elif a_func == Function.ARCSIN:
        # Input
        x = random.uniform(-0.9, 0.9)
        y = 1 - (x**2)
        z = 0.0
        # Expected
        x_exp = (1 / AN) * np.sqrt((x**2) + (y))
        y_exp = None
        z_exp = np.asin(x)
    elif a_func == Function.ARCCOS:
        # Input
        x = random.uniform(0, 0.9)
        y = 1 - (x**2)
        z = 0.0
        # Expected
        x_exp = (1 / AN) * np.sqrt((x**2) + (y))
        y_exp = None
        z_exp = np.acos(x)
    elif a_func == Function.ARCTAN:
        # Input
        x = random.uniform(0, 1)
        y = random.uniform(0, 10)
        z = 0.0
        # Expected
        x_exp = (1 / AN) * np.sqrt((x**2) + (y**2))
        y_exp = None
        z_exp = np.arctan(y / x)
    elif a_func == Function.POL_TO_REC:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(0, 2 * np.pi)
        # Expected
        x_exp = 1.0 * np.cos(z)
        y_exp = 1.0 * np.sin(z)
        z_exp = None
        pass
    elif a_func == Function.REC_TO_POL:
        # For large inputs the error increases marginally
        # Input
        x = random.uniform(0, 10)
        y = random.uniform(0, 10)
        z = 0.0
        # Expected
        x_exp = (1 / AN) * np.sqrt((x**2) + (y**2))
        y_exp = None
        z_exp = np.arctan(y / x)
        pass
    elif a_func == Function.MULT:
        x = random.uniform(0, 100)
        y = 0.0
        z = random.uniform(0, 100)
        x_exp = x
        y_exp = y + (x * z)
        z_exp = None
    elif a_func == Function.DIV:
        x = random.uniform(0, 100)
        y = random.uniform(0, 100)
        z = 0.0
        x_exp = x
        y_exp = None
        z_exp = z + (y / x)
    elif a_func == Function.RECIPROCAL:
        x = random.uniform(0.4, 1)
        y = 0.0
        z = 0.0
        x_exp = x
        y_exp = None
        z_exp = z + (1 / x)
    elif a_func == Function.SINH_COSH:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(0, 100)
        # Expected
        x_exp = np.cosh(z)
        y_exp = np.sinh(z)
        z_exp = None
    elif a_func == Function.TANH:
        # Input
        x = 0.0
        y = 0.0
        # z = random.uniform(0, np.deg2rad(45))
        z = random.uniform(0, 100)
        # Expected
        x_exp = np.cosh(z)
        y_exp = None
        z_exp = np.tanh(z)
    elif a_func == Function.ARCSINH:
        # Input
        x = 0.0
        y = random.uniform(0.0, 1)
        z = 0.0
        # Expected
        x_exp = 0.5
        y_exp = 0.0
        z_exp = np.log(y + np.sqrt((y**2) + 1))
    elif a_func == Function.ARCCOSH:
        # Input
        x = random.uniform(1.2, 2)
        y = 0.0
        z = 0.0
        # Expected
        x_exp = 0.5
        y_exp = 0.0
        z_exp = np.log(x + np.sqrt((x**2) - 1))
    elif a_func == Function.ARCTANH:
        # Input
        x = random.uniform(0, 0.1)
        y = x / 2
        z = 0.0
        # Expected
        x_exp = AN_HYP * np.sqrt((x**2) - (y**2))
        y_exp = 0.0
        z_exp = z + np.arctanh(y / x)
    elif a_func == Function.SQRT:
        x = random.uniform(0, 1000)
        y = x
        z = 0.0
        x_exp = np.sqrt(x)
        y_exp = None
        z_exp = None
        # z_exp = (
        #     0.5 * np.log(x * (1 / AN**2)) + 0.0057835
        # )  # i have no clue why I need to use AN and bias here :S
    elif a_func == Function.LN:
        x = random.uniform(0.1, 70)
        y = x
        z = 0.0
        x_exp = 0.5
        y_exp = None
        z_exp = np.log(x)
    elif a_func == Function.EXP:
        x = 0.0
        y = 0.0
        z = random.uniform(0, 10)
        x_exp = np.exp(z)
        y_exp = np.exp(z)
        z_exp = None
    elif a_func == Function.POW:
        x = random.uniform(0.1, 100)
        y = x
        z = random.uniform(0.1, 100)
        x_exp = x ** (z / 2)
        y_exp = x ** (z / 2)
        z_exp = None
    elif a_func == Function.SEC:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(np.deg2rad(-89), np.deg2rad(89))
        # Expected
        x_exp = np.sin(z)
        y_exp = None
        z_exp = 1 / np.sin(z)
    elif a_func == Function.CSC:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(np.deg2rad(1), np.deg2rad(179))
        # Expected
        x_exp = np.cos(z)
        y_exp = None
        z_exp = 1 / np.cos(z)
    elif a_func == Function.COT:
        # Input
        x = 0.0
        y = 0.0
        z = random.uniform(np.deg2rad(30), np.deg2rad(70))
        z = random.uniform(np.deg2rad(1), np.deg2rad(178))
        # Expected
        x_exp = np.tan(z)
        y_exp = None
        z_exp = 1 / np.tan(z)
    # elif a_func == Function.SECH:
    #     # Input
    #     x = 0.0
    #     y = 0.0
    #     z = random.uniform(np.deg2rad(0), np.deg2rad(70))
    #     # Expected
    #     x_exp = np.sinh(z)
    #     y_exp = 0.0
    #     z_exp = 1 / np.sinh(z)
    # elif a_func == Function.CSCH:
    #     # Input
    #     x = 0.0
    #     y = 0.0
    #     z = random.uniform(0, np.deg2rad(45))
    #     z = random.uniform(np.deg2rad(30), np.deg2rad(70))
    #     # Expected
    #     x_exp = np.cosh(z)
    #     y_exp = 0.0
    #     z_exp = 1 / np.cosh(z)
    # elif a_func == Function.COTH:
    #     # Input
    #     x = 0.0
    #     y = 0.0
    #     z = random.uniform(0, np.deg2rad(45))
    #     # Expected
    #     x_exp = np.tanh(z)
    #     y_exp = 0.0
    #     z_exp = 1 / np.tanh(z)

    x_res, y_res, z_res = execute_cordic(
        a_func=a_func,
        a_x=x,
        a_y=y,
        a_z=z,
        a_nbr_of_iterations=NBR_OF_ITERATIONS,
    )

    result = [x_res, y_res, z_res]
    print(result)
    expected = [x_exp, y_exp, z_exp]
    diff_percent = []
    for r, e in zip(result, expected):
        if e is None:
            continue
        # diff = np.abs(r - e) / (np.abs(e) + 1e-12)
        diff_percent = (np.abs(r - e) / (np.abs(e))) * 100.0
        if diff_percent < 1.0:
            pass
        else:
            print_results(
                a_title=f"{a_func.name} Input",
                a_x=x,
                a_y=y,
                a_z=np.rad2deg(z),
                # a_title=f"{a_func.name} Input",
                # a_x=x,
                # a_y=y,
                # a_z=z,
            )
            print_results(
                a_title=f"{a_func.name} Obtained", a_x=x_res, a_y=y_res, a_z=z_res
            )
            print_results(
                a_title=f"{a_func.name} Expected", a_x=x_exp, a_y=y_exp, a_z=z_exp
            )
            raise ValueError(f">> ERROR! {a_func.name} Diff={diff_percent} % <<")

    print()


if __name__ == "__main__":
    # ===============================
    # PARAMETERS
    NBR_OF_ITERATIONS = 40
    # ===============================
    for _ in range(1):
        for function in (
            Function.SIN_COS,  # DONE
            # Function.TAN,  # DONE
            # Function.ARCSIN,  # DONE
            # Function.ARCCOS,  # DONE
            # Function.ARCTAN,  # DONE
            # Function.POL_TO_REC,  # DONE
            # Function.REC_TO_POL,  # DONE
            # Function.MULT,  # DONE
            # Function.DIV,  # DONE
            # Function.RECIPROCAL,  # DONE
            # Function.SINH_COSH,  # DONE
            # Function.TANH,  # DONE
            # Function.ARCSINH,
            # Function.ARCCOSH,
            # Function.ARCTANH,
            # Function.SQRT,  # DONE
            # Function.LN,  # DONE
            # Function.EXP,  # DONE
            # Function.POW,  # DONE
            # Function.SEC,  # DONE
            # Function.CSC,  # DONE
            # Function.COT,  # DONE
            # # BIBIBIIB
            # Function.SECH,
            # Function.CSCH,
            # Function.COTH,
        ):
            test_function(a_func=function)
    print("All passed!")
