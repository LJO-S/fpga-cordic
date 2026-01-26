library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
library JSON;
context JSON.json_ctx;
-- 
package tb_pkg is
    -------------------
    -- Functions
    -------------------
    function f_pad_str (str : string; ln : integer) return string;
    function f_json_mode (mode       : string) return t_mode;
    function f_json_submode (submode : string) return t_submode;

end package;

package body tb_pkg is
    -------------------
    -- Functions
    -------------------

    function f_pad_str (str : string; ln : integer) return string is
        variable v_string : string(1 to ln) := (others => ' ');
    begin
        if (str'length < v_string'length) then -- SMALLER
            v_string(1 to str'length) := str;
        else -- LARGER
            v_string := str(str'low to str'low + v_string'length - 1);
        end if;
        return v_string;
    end function;

    function f_json_mode (
        mode : string
    ) return t_mode is
        variable v_mode_str : string(1 to 10);
    begin
        v_mode_str := f_pad_str(mode, v_mode_str'length);
        case v_mode_str is
            when "VECTORING " =>
                return VECTORING;
            when "ROTATIONAL" =>
                return ROTATIONAL;
            when others =>
                assert false report "Unknown mode from JSON file!" severity failure;
                return ROTATIONAL;
        end case;
    end function;

    function f_json_submode (
        submode : string
    ) return t_submode is
        variable v_submode_str : string(1 to 10);
    begin
        v_submode_str := f_pad_str(submode, v_submode_str'length);
        case v_submode_str is
            when "LINEAR    " =>
                return LINEAR;
            when "CIRCULAR  " =>
                return CIRCULAR;
            when "HYPERBOLIC" =>
                return HYPERBOLIC;
            when others =>
                assert false report "Unknown submode from JSON file!" severity failure;
                return HYPERBOLIC;
        end case;
    end function;

    -- function f_json_init (
    --     init_type   : string;
    --     init_offset : real
    -- ) return real is
    --     variable v_type_str : string(1 to 2 ** 8) := (others => C_JSON_NUL);
    --     variable v_input_a : real;
    -- begin
    --     -- v_submode_str := f_pad_str(submode, v_submode_str'length);
    --     v_type_str(1 to init_type'length) := init_type(init_type'low to init_type'high);
    --     -- v_submode_str := f_pad_str(submode, v_submode_str'length);
    --     case jsonTrim(v_type_str) is
    --         when "PROC_GAIN" =>
    --             v_input_a := 0.
    --         when "CIRCULAR  " =>
    --             return CIRCULAR;
    --         when "HYPERBOLIC" =>
    --             return HYPERBOLIC;
    --         when others =>
    --             assert false report "Unknown submode from JSON file!" severity failure;
    --             return HYPERBOLIC;
    --     end case;
    -- end function;

end package body;