from pathlib import Path
import json
from jinja2 import Environment, FileSystemLoader
from copy import deepcopy
import math
import os

# Generate:
# 1. MICROCODE STEP ROM
# 2. MICROCODE META ROM
# 3. CONST_POOL ROM


def deep_merge(a_base, a_update):
    """
    Recursively merges 'a_update' into 'a_base'.
    """
    base = deepcopy(a_base)
    for key, value in a_update.items():
        if isinstance(value, dict) and key in base and isinstance(base[key], dict):
            # Both in dict, go deeper
            base[key] = deep_merge(base[key], value)
        else:
            # Not a dict or key doesnt exist in base, overwrite
            base[key] = value
    return base


def get_functions(a_json_path: Path):
    # 1. Parse JSON
    with Path(a_json_path).open("r", encoding="utf-8") as fptr:
        json_obj = json.loads(fptr.read())
    functions = []
    for func_name, _ in json_obj["functions"].items():
        functions.append(func_name)
    return functions


def generate_microcode_rom(
    a_json_path: Path,
    a_input_path: Path = Path("./jinja_templates"),
    a_output_path: Path = Path("../../src/pkg/cordic_microcode_pkg.vhd"),
    a_data_width_norm: int = 27,
    a_data_width_frac: int = 25,
):
    def to_fixed_binary(a_val: float):
        """
        Custom Jinja2 filter to convert float to VHDL signed hex.
        """
        integer_val = int(round(a_val * (2**a_data_width_frac)))
        max_val = (2 ** (a_data_width_norm - 1)) - 1
        min_val = -(2 ** (a_data_width_norm - 1))
        if integer_val > max_val or integer_val < min_val:
            print(
                f"WARNING: Constant {a_val} overflows {a_data_width_norm}-bit format!"
            )
            integer_val = max_val if integer_val > 0 else min_val
        if integer_val < 0:
            integer_val = (1 << a_data_width_norm) + integer_val
        return f'"{integer_val:0{a_data_width_norm}b}"'

    def to_int_log2(a_val: int):
        """
        Custom Jinja2 filter to convert int to log2 bits.
        """
        return int(math.ceil(math.log2(a_val)))

    # 1. Parse JSON
    with Path(a_json_path).open("r", encoding="utf-8") as fptr:
        json_obj = json.loads(fptr.read())

    default = json_obj["default"]

    constant_pool = []

    def get_const_id(a_val: int):
        if a_val not in constant_pool:
            constant_pool.append(a_val)
        return constant_pool.index(a_val)

    # 2. Process Functions
    compiled_steps = []
    function_table = []

    for func_name, steps in json_obj["functions"].items():
        # Set PTR
        function_table.append(dict(name=func_name, start_addr=len(compiled_steps)))
        for step in steps:
            # Deep merge defaults
            full_step = deep_merge(default, step)

            # Extract CONSTANT POOL ID
            for axis in ["x", "y", "z"]:
                offset_val = full_step["init"][axis]["offset"]
                full_step["init"][axis]["const_id"] = get_const_id(offset_val)
            full_step["last"] = False
            compiled_steps.append(full_step)

        compiled_steps[-1]["last"] = True

    # 3. Generate VHDL from Jinja2 template

    # Setup Jinja2 environ
    env = Environment(loader=FileSystemLoader(a_input_path))
    env.filters["to_fixed_binary"] = to_fixed_binary
    env.filters["log2"] = to_int_log2
    template = env.get_template("cordic_microcode_pkg.vhd.j2")

    # Prepare data
    context = {
        "data_width": a_data_width_norm,
        "functions": function_table,
        "constants": constant_pool,
        "steps": compiled_steps,
    }

    a_output_path.parent.mkdir(exist_ok=True, parents=True)
    with open(a_output_path, "w") as f:
        f.write(template.render(context))


if __name__ == "__main__":
    JSON_FILEPATH = Path(f"../microcodes.json")
    OUTPUT_PATH = Path("../../src/pkg/cordic_microcode_pkg.vhd")
    G_DATA_WIDTH_DENORM = 35
    G_DATA_WIDTH_NORM = 29
    G_DATA_WIDTH_FRAC = 27
    generate_microcode_rom(
        a_json_path=JSON_FILEPATH,
        a_output_path=OUTPUT_PATH,
        a_data_width_norm=G_DATA_WIDTH_NORM,
        a_data_width_frac=G_DATA_WIDTH_FRAC,
    )
    print("Generated microcodes successfully!")
