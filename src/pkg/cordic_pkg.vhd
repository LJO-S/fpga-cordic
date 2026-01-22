library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package cordic_pkg is
    -- ---------------
    -- Constants
    -- ---------------
    constant C_LINEAR     : std_logic_vector(1 downto 0) := "00";
    constant C_CIRCULAR   : std_logic_vector(1 downto 0) := "01";
    constant C_HYPERBOLIC : std_logic_vector(1 downto 0) := "10";
    constant C_VECTORING  : std_logic                    := '1';
    constant C_ROTATIONAL : std_logic                    := '0';
    -- ---------------
    -- Types
    -- ---------------
    type t_mode is (LINEAR, CIRCULAR, HYPERBOLIC);
    type t_submode is (VECTORING, ROTATIONAL);
    -- ---------------
    -- Functions
    -- ---------------
    function f_mode_translate (mode_slv    : std_logic_vector(1 downto 0)) return t_mode;
    function f_submode_translate (mode_slv : std_logic) return t_submode;
end package;

package body cordic_pkg is
    -- ----------------------------------------------------------
    function f_mode_translate (
        mode_slv : std_logic_vector(1 downto 0)
    ) return t_mode is
    begin
        case mode_slv is
            when "00" =>
                return LINEAR;
            when "01" =>
                return CIRCULAR;
            when "10" =>
                return HYPERBOLIC;
            when others =>
                return LINEAR;
        end case;
    end function;
    -- ----------------------------------------------------------
    function f_submode_translate (
        mode_slv : std_logic
    ) return t_submode is
    begin
        case mode_slv is
            when '0' =>
                return VECTORING;
            when '1' =>
                return ROTATIONAL;
            when others =>
                return VECTORING;
        end case;
    end function;
    -- ----------------------------------------------------------

end package body;