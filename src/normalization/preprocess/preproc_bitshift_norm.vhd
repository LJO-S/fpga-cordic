library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
entity preproc_bitshift_norm is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_SHIFT_WIDTH       : natural := 5
    );
    port (
        clk : in std_logic;
        -- Cfg
        i_shift_double : std_logic;
        i_shift_common : std_logic;
        i_shift_inputs : std_logic_vector(2 downto 0);
        -- Input
        i_x     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_valid : in std_logic;
        -- Output
        o_x       : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_y       : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_z       : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_x_shift : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_y_shift : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_z_shift : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_valid   : out std_logic
    );
end entity preproc_bitshift_norm;

architecture rtl of preproc_bitshift_norm is
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
        return G_DATA_WIDTH_FRAC;
    end function;
    -----------------
    -- Constants
    -----------------
    -----------------
    -- Types
    -----------------
    -----------------
    -- Signals
    -----------------
    signal r_shift_common    : std_logic                                                    := '0';
    signal r_shift_double    : std_logic                                                    := '0';
    signal r_shift_double_d0 : std_logic                                                    := '0';
    signal r_x_abs_int       : signed(G_DATA_WIDTH_DENORM + G_DATA_WIDTH_FRAC - 1 downto 0) := (others => '0');
    signal r_y_abs_int       : signed(G_DATA_WIDTH_DENORM + G_DATA_WIDTH_FRAC - 1 downto 0) := (others => '0');
    signal r_z_abs_int       : signed(G_DATA_WIDTH_DENORM + G_DATA_WIDTH_FRAC - 1 downto 0) := (others => '0');
    signal r_valid           : std_logic                                                    := '0';
    signal r_valid_d0        : std_logic                                                    := '0';
    signal r_valid_d1        : std_logic                                                    := '0';
    signal r_valid_d2        : std_logic                                                    := '0';
    signal r_shift_x         : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_y         : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_z         : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_x_d0      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_y_d0      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_z_d0      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_x_d1      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_y_d1      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_shift_z_d1      : signed(G_SHIFT_WIDTH - 1 downto 0)                           := (others => '0');
    signal r_x               : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_y               : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_z               : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_x_d0            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_y_d0            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_z_d0            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_x_d1            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_y_d1            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_z_d1            : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_xval_shift      : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_yval_shift      : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
    signal r_zval_shift      : signed(G_DATA_WIDTH_DENORM - 1 downto 0)                     := (others => '0');
begin
    -- ===================================================================
    o_x       <= std_logic_vector(r_xval_shift(o_x'range));
    o_y       <= std_logic_vector(r_yval_shift(o_y'range));
    o_z       <= std_logic_vector(r_zval_shift(o_z'range));
    o_x_shift <= std_logic_vector(r_shift_x_d1);
    o_y_shift <= std_logic_vector(r_shift_y_d1);
    o_z_shift <= std_logic_vector(r_shift_z_d1);
    o_valid   <= r_valid_d2;
    -- ===================================================================
    process (clk)
        variable v_shift_x : signed(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        variable v_shift_y : signed(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        variable v_shift_z : signed(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        variable v_iflog_x : integer;
        variable v_iflog_y : integer;
        variable v_iflog_z : integer;
    begin
        if rising_edge(clk) then
            -----------------
            -- PIPE 0
            -----------------
            -- Prepare data
            r_x_abs_int <= (others => '0');
            r_y_abs_int <= (others => '0');
            r_z_abs_int <= (others => '0');
            if (i_shift_inputs(0) = '1') then
                r_x_abs_int <= abs(resize(signed(i_x), r_x_abs_int'length));
            end if;
            if (i_shift_inputs(1) = '1') then
                r_y_abs_int <= abs(resize(signed(i_y), r_x_abs_int'length));
            end if;
            if (i_shift_inputs(2) = '1') then
                r_z_abs_int <= abs(resize(signed(i_z), r_x_abs_int'length));
            end if;
            r_x            <= signed(i_x);
            r_y            <= signed(i_y);
            r_z            <= signed(i_z);
            r_valid        <= i_valid;
            r_shift_double <= i_shift_double;
            r_shift_common <= i_shift_common;
            -----------------
            -- PIPE 1
            -----------------

            -- synthesis translate_off
            v_iflog_x := f_ilog2(std_logic_vector(r_x_abs_int));
            v_iflog_y := f_ilog2(std_logic_vector(r_y_abs_int));
            v_iflog_z := f_ilog2(std_logic_vector(r_y_abs_int));
            -- synthesis translate_on

            -- Calculate Leading Zero Count
            v_shift_x := to_signed(f_ilog2(std_logic_vector(r_x_abs_int)) - G_DATA_WIDTH_FRAC, r_shift_x'length);
            v_shift_y := to_signed(f_ilog2(std_logic_vector(r_y_abs_int)) - G_DATA_WIDTH_FRAC, r_shift_y'length);
            v_shift_z := to_signed(f_ilog2(std_logic_vector(r_z_abs_int)) - G_DATA_WIDTH_FRAC, r_shift_z'length);

            -- Shift common
            if (r_shift_common = '1') then
                if (v_shift_x > v_shift_y) then
                    v_shift_y := v_shift_x;
                else
                    v_shift_x := v_shift_y;
                end if;
            end if;

            r_shift_x <= v_shift_x;
            r_shift_y <= v_shift_y;
            r_shift_z <= v_shift_z;

            r_x_d0            <= r_x;
            r_y_d0            <= r_y;
            r_z_d0            <= r_z;
            r_valid_d0        <= r_valid;
            r_shift_double_d0 <= r_shift_double;

            -----------------
            -- PIPE 2
            -----------------
            r_shift_x_d0 <= r_shift_x;
            r_shift_y_d0 <= r_shift_y;
            r_shift_z_d0 <= r_shift_z;
            -- Double shift
            if (r_shift_double_d0 = '1') then
                -- X
                r_shift_x_d0 <= r_shift_x + 2;
                if (r_shift_x(r_shift_x'low) = '1') then
                    r_shift_x_d0 <= r_shift_x + 1;
                end if;
                -- Y
                r_shift_y_d0 <= r_shift_y + 2;
                if (r_shift_y(r_shift_y'low) = '1') then
                    r_shift_y_d0 <= r_shift_y + 1;
                end if;
            end if;
            r_x_d1     <= r_x_d0;
            r_y_d1     <= r_y_d0;
            r_z_d1     <= r_z_d0;
            r_valid_d1 <= r_valid_d0;
            -----------------
            -- PIPE 2
            -----------------
            -- Shift data
            if (r_shift_x_d0 >= 0) then
                r_xval_shift <= shift_right(signed(r_x_d1), to_integer(r_shift_x_d0));
            else
                r_xval_shift <= shift_left(signed(r_x_d1), -to_integer(r_shift_x_d0));
            end if;
            if (r_shift_y_d0 >= 0) then
                r_yval_shift <= shift_right(signed(r_y_d1), to_integer(r_shift_y_d0));
            else
                r_yval_shift <= shift_left(signed(r_y_d1), -to_integer(r_shift_y_d0));
            end if;
            if (r_shift_z_d0 >= 0) then
                r_zval_shift <= shift_right(signed(r_z_d1), to_integer(r_shift_z_d0));
            else
                r_zval_shift <= shift_left(signed(r_z_d1), -to_integer(r_shift_z_d0));
            end if;
            r_shift_x_d1 <= r_shift_x_d0;
            r_shift_y_d1 <= r_shift_y_d0;
            r_shift_z_d1 <= r_shift_z_d0;
            r_valid_d2   <= r_valid_d1;
        end if;
    end process;
    -- ===================================================================
end architecture;