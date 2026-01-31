library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity cordic_preprocess is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30
    );
    port (
        clk : in std_logic;
        -- Configuration
        i_config : t_normalization;
        -- Input Data
        i_x : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        -- Input Valid/Ready
        i_valid : in std_logic;
        o_ready : out std_logic;
        -- Output Data
        o_x     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_z     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_meta  : out t_normalization_meta;
        i_ready : in std_logic;
        o_valid : out std_logic
    );
end entity cordic_preprocess;

architecture rtl of cordic_preprocess is
    -----------------
    --  Functions
    -----------------
    function f_ilog2 (
        slv_in : std_logic_vector
    ) return integer is
        variable v_count : integer;
    begin
        v_count := 0;
        for i in slv_in'high downto slv_in'low loop
            if (slv_in(i) = '1') then
                return slv_in'high - v_count;
            else
                v_count := v_count + 1;
            end if;
        end loop;
        return 0;
    end function;

    function f_float_to_signed (
        val        : real;
        data_width : natural;
        frac_width : natural
    ) return signed is
        variable v_val_fixed : real;
        variable v_val_int   : integer;
    begin
        v_val_fixed := val * (2.0 ** frac_width);
        v_val_int   := integer(ceil(v_val_fixed));
        return to_signed(v_val_int, data_width);
    end function;
    ----------------
    -- Constants
    ----------------
    constant C_MATH_2_PI_SIGNED       : signed(G_DATA_WIDTH_NORM - 1 downto 0) := f_float_to_signed(2.0 * MATH_PI, G_DATA_WIDTH_DENORM, G_DATA_WIDTH_FRAC);
    constant C_MATH_PI_SIGNED         : signed(G_DATA_WIDTH_NORM - 1 downto 0) := shift_right(C_MATH_2_PI_SIGNED, 1);
    constant C_MATH_PI_DIV_2_SIGNED   : signed(G_DATA_WIDTH_NORM - 1 downto 0) := shift_right(C_MATH_PI_SIGNED, 1);
    constant C_MATH_3_PI_DIV_2_SIGNED : signed(G_DATA_WIDTH_NORM - 1 downto 0) := C_MATH_PI_SIGNED + shift_right(C_MATH_PI_SIGNED, 1);
    constant C_ROUND_ADD              : SIGNED(XXX)                            := to_signed(2 ** (G_DATA_WIDTH_FRAC - 1), XXX);
    ----------------
    -- Types
    ----------------
    type t_preproc_state is (IDLE, NORMALIZE, RANGE_REDUCE, QUADRANT_MAP);
    signal s_preproc_state : t_preproc_state := IDLE;
    ----------------
    -- Signals
    ----------------
    signal r_shift_x_st0 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_y_st0 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_z_st0 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_x_st1 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_y_st1 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_z_st1 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_x_st2 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_y_st2 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_shift_z_st2 : signed(integer(ceil(log2(real(G_DATA_WIDTH_DENORM - G_DATA_WIDTH_NORM)))) - 1 downto 0) := (others => '0');
    signal r_x_norm      : signed(i_x'range)                                                                       := (others => '0');
    signal r_y_norm      : signed(i_y'range)                                                                       := (others => '0');
    signal r_z_norm      : signed(i_z'range)                                                                       := (others => '0');

begin
    -- ===================================================================
    -- TODO fsm
    -- ===================================================================
    -- Bitshift normalization
    -- Normalize (x,y) by shifting so that abs(x) is in [1,2) (or similar)
    p_normalize : process (clk)
        variable v_shift_x : integer := 0;
        variable v_shift_y : integer := 0;
        variable v_shift_z : integer := 0;
    begin
        if rising_edge(clk) then
            -------------
            -- PIPE 0
            -------------
            r_shift_x_st0 <= to_signed(f_ilog2(i_x), r_shift_x_st0'length);
            r_shift_y_st0 <= to_signed(f_ilog2(i_y), r_shift_y_st0'length);
            r_shift_z_st0 <= to_signed(f_ilog2(i_z), r_shift_z_st0'length);
            -------------
            -- PIPE 1
            -------------
            r_shift_x_st1 <= r_shift_x_st0;
            r_shift_y_st1 <= r_shift_y_st0;
            r_shift_z_st1 <= r_shift_z_st0;
            if (i_config.norm_common = '1') then
                if (r_shift_x_st0 >= r_shift_y_st0) then
                    r_shift_y_st1 <= r_shift_x_st0;
                else
                    r_shift_x_st1 <= r_shift_y_st1;
                end if;
            end if;
            -------------
            -- PIPE 2
            -------------
            r_shift_x_st2 <= r_shift_x_st1;
            r_shift_y_st2 <= r_shift_y_st1;
            r_shift_z_st2 <= r_shift_z_st1;
            if (i_config.norm_shift_double = '1') then
                -- Mod 2
                if (r_shift_x_st1(r_shift_x_st1'low) = '1') then
                    r_shift_x_st2 <= r_shift_x_st1 - 1;
                end if;
                if (r_shift_y_st1(r_shift_y_st1'low) = '1') then
                    r_shift_y_st2 <= r_shift_y_st1 - 1;
                end if;
            end if;
            -------------
            -- PIPE 3
            -------------
            -- Apply shifts
            v_shift_x := to_integer(r_shift_x_st2);
            v_shift_y := to_integer(r_shift_y_st2);
            v_shift_z := to_integer(r_shift_z_st2);
            -- TODO use these from an external FSM
            r_x_norm <= shift_right(r_x_norm_input, v_shift_x) when v_shift_x >= 0 else
                shift_left(r_x_norm_input, -v_shift_x);
            r_y_norm <= shift_right(r_y_norm_input, v_shift_y) when v_shift_y >= 0 else
                shift_left(r_y_norm_input, -v_shift_y);
            r_z_norm <= shift_right(r_z_norm_input, v_shift_z) when v_shift_z >= 0 else
                shift_left(r_z_norm_input, -v_shift_z);
        end if;
    end process;
    -- ===================================================================
    -- Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
    -- This variant reduces by integer multiples of ln(2): z = r + n*ln2
    p_range_reduce : process (clk)
        variable v_range_n_shift  : signed(r_range_n_mult'range) := (others => '0');
        variable v_subtract_shift : signed(r_range_n_mult'range) := (others => '0');
    begin
        if rising_edge(clk) then
            -------------
            -- PIPE 0
            -------------
            r_range_n_mult <= r_prerange_z * C_LN2_INV_SIGNED;
            -------------
            -- PIPE 1
            -------------
            v_range_n_shift := shift_right(r_range_n_mult + C_ROUND_ADD, G_DATA_FRAC_WIDTH);
            r_range_n <= v_range_n_shift(r_range_n'range);
            -------------
            -- PIPE 2
            -------------
            r_range_n_d0 <= r_range_n;
            r_subtract   <= r_range_n * C_LN2_SIGNED;
            -------------
            -- PIPE 3
            -------------
            v_subtract_shift := shift_right(r_subtract, G_DATA_FRAC_WIDTH);
            r_range_r <= r_z - v_subtract_shift(r_z'range);
        end if;
    end process p_range_reduce;
    -- ===================================================================
    -- Quadrant Mapping
    -- Maps angle z into the principal quadrant [0, pi/2).
    p_quadrant_map : process (clk)
        variable v_quadrant : integer := 0;
    begin
        if rising_edge(clk) then
            -------------
            -- PIPE 0
            -------------
            if (r_z_prequad >= 0) and (r_z_prequad < C_MATH_PI_DIV_2_SIGNED) then
                v_quadrant := 1;
                r_z_postquad <= r_z_prequad;
            elsif (r_z_prequad >= C_MATH_PI_DIV_2_SIGNED) and (r_z_prequad < C_MATH_PI_SIGNED) then
                v_quadrant := 2;
                r_z_postquad <= C_MATH_PI - r_z_prequad;
            elsif (r_z_prequad >= C_MATH_3_PI_DIV_2_SIGNED) and (r_z_prequad < C_MATH_2_PI_SIGNED) then
                v_quadrant := 3;
                r_z_postquad <= r_z_prequad - C_MATH_PI;
            else
                v_quadrant := 4;
                r_z_postquad <= C_MATH_PI_MULT_2 - r_z_prequad;
            end if;
        end if;
    end process p_quadrant_map;
    -- ===================================================================
end architecture;