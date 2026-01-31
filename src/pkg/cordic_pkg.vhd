library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package cordic_pkg is
    -- ---------------
    -- Constants
    -- ---------------
    -- Mode/submode
    constant C_LINEAR     : std_logic_vector(1 downto 0) := "00";
    constant C_CIRCULAR   : std_logic_vector(1 downto 0) := "01";
    constant C_HYPERBOLIC : std_logic_vector(1 downto 0) := "10";
    constant C_VECTORING  : std_logic                    := '1';
    constant C_ROTATIONAL : std_logic                    := '0';
    -- Parameters
    constant C_DATA_WIDTH        : natural := 32;
    constant C_FRAC_WIDTH        : natural := 30;
    constant C_NBR_OF_ITERATIONS : natural := 40;
    constant C_MAX_NBR_OF_STEPS  : natural := 4;
    -- ---------------
    -- Types
    -- ---------------
    type t_mode is (VECTORING, ROTATIONAL);
    type t_submode is (LINEAR, CIRCULAR, HYPERBOLIC);

    type t_normalization is record
        -- Shift normalization
        norm_en           : std_logic;
        norm_input        : std_logic_vector(2 downto 0);
        norm_common       : std_logic;
        norm_shift_double : std_logic;
        -- Range reduction
        reduction_en          : std_logic;
        reduction_reconstruct : std_logic;
        -- Quadrant mapping
        quadrant_en : std_logic;
    end record;

    type t_normalization_meta is record
        shift_x  : integer;
        shift_y  : integer;
        shift_z  : integer;
        quadrant : unsigned(1 downto 0);
        range_n  : integer;
    end record;

    type t_initialization_type is (
        PROC_GAIN,
        PROC_GAIN_INV,
        PROC_GAIN_HYP,
        PROC_GAIN_HYP_INV,
        CONST,
        INPUT_X,
        INPUT_Y,
        INPUT_Z,
        OUTPUT_X,
        OUTPUT_Y,
        OUTPUT_Z
    );
    type t_initialization is record
        source : t_initialization_type;
        offset : std_logic_vector(C_DATA_WIDTH - 1 downto 0);
    end record;

    type t_initialization_array is array (0 to 2) of t_initialization;

    type t_step is record
        mode    : t_mode;
        submode : t_submode;
        init    : t_initialization_array;
        norm    : t_normalization;
    end record;

    type t_step_array is array (natural range <>) of t_step;

    type t_microcode is record
        step         : t_step;
        nbr_of_steps : integer;
    end record;

    -- TODO microcode registry

    -- ---------------
    -- Functions
    -- ---------------
    function f_mode_translate (mode_slv    : std_logic) return t_mode;
    function f_submode_translate (mode_slv : std_logic_vector(1 downto 0)) return t_submode;
    function f_real_to_signed (val : real; data_width : natural; frac_width : natural) return signed;

end package;

package body cordic_pkg is
    -- ----------------------------------------------------------
    function f_submode_translate (
        mode_slv : std_logic_vector(1 downto 0)
    ) return t_submode is
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
    function f_mode_translate (
        mode_slv : std_logic
    ) return t_mode is
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
    function f_real_to_signed (
        val        : real;
        data_width : natural;
        frac_width : natural
    ) return signed is
        variable v_integer : integer;
        variable v_signed  : signed(data_width - 1 downto 0);
    begin
        v_integer := integer(ceil(val * (2.0 ** frac_width)));
        assert v_integer <= (2 ** (data_width - 1))
        report "The desired data_width cannot hold this variable!"
            severity failure;
        v_signed := to_signed(v_integer, data_width);
        return v_signed;
    end function;
end package body;