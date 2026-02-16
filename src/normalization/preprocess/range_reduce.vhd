library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity range_reduce is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_RANGE_N_WIDTH     : natural := 10
    );
    port (
        clk : in std_logic;
        -- Input Data
        i_x     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_valid : in std_logic;
        -- Output Data
        o_x     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_r     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_n     : out std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
        o_valid : out std_logic
    );
end entity range_reduce;

architecture rtl of range_reduce is
    -----------------
    --  Functions
    -----------------

    ----------------
    -- Constants
    ----------------
    constant C_LN2_REAL       : real                                   := 0.6931471806;
    constant C_LN2_INV_REAL   : real                                   := 1.0 / C_LN2_REAL;
    constant C_LN2_SIGNED     : signed(G_DATA_WIDTH_NORM - 1 downto 0) := to_signed(integer(C_LN2_REAL * (2.0 ** (G_DATA_WIDTH_FRAC))), G_DATA_WIDTH_NORM);
    constant C_LN2_INV_SIGNED : signed(G_DATA_WIDTH_NORM - 1 downto 0) := to_signed(integer(C_LN2_INV_REAL * (2.0 ** (G_DATA_WIDTH_FRAC))), G_DATA_WIDTH_NORM);
    constant C_ROUND_ADD      : signed(G_DATA_WIDTH_FRAC - 1 downto 0) := to_signed(2 ** (G_DATA_WIDTH_FRAC - 1), G_DATA_WIDTH_FRAC);
    ----------------
    -- Types
    ----------------
    ----------------
    -- Signals
    ----------------
    -- Pipe
    signal r_x        : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_y        : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_z        : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_x_d0     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_y_d0     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_z_d0     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_x_d1     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_y_d1     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_z_d1     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_x_d2     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_y_d2     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0)   := (others => '0');
    signal r_valid    : std_logic                                          := '0';
    signal r_valid_d0 : std_logic                                          := '0';
    signal r_valid_d1 : std_logic                                          := '0';
    signal r_valid_d2 : std_logic                                          := '0';
    -- Mult
    signal r_range_n_mult : signed(G_DATA_WIDTH_DENORM + G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_range_n      : signed(G_RANGE_N_WIDTH - 1 downto 0)                         := (others => '0');
    signal r_range_n_d0   : signed(G_RANGE_N_WIDTH - 1 downto 0)                         := (others => '0');
    signal r_range_n_d1   : signed(G_RANGE_N_WIDTH - 1 downto 0)                         := (others => '0');
    signal r_subtract     : signed(G_RANGE_N_WIDTH + G_DATA_WIDTH_NORM - 1 downto 0)     := (others => '0');
    signal r_range_r      : signed(r_subtract'range)                                     := (others => '0');
begin
    -- ===================================================================
    -- Combinatorial
    o_x     <= r_x_d2;
    o_y     <= r_y_d2;
    o_r     <= std_logic_vector(r_range_r(o_r'range));
    o_n     <= std_logic_vector(r_range_n_d1);
    o_valid <= r_valid_d2;
    -- ===================================================================
    -- Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
    -- This variant reduces by integer multiples of ln(2): z = r + n*ln2
    p_range_reduce : process (clk)
        variable v_range_n_shift  : signed(r_range_n_mult'range) := (others => '0');
        variable v_subtract_shift : signed(r_subtract'range)     := (others => '0');
    begin
        if rising_edge(clk) then
            -------------
            -- PIPE 0
            -------------
            r_valid <= i_valid;
            -- Truncate
            r_x <= i_x(r_x'range);
            r_y <= i_y(r_y'range);
            r_z <= i_z;
            -- Calculate round(a_z / ln2) pt1
            r_range_n_mult <= (signed(i_z) * C_LN2_INV_SIGNED);
            -------------
            -- PIPE 1
            -------------
            r_x_d0     <= r_x;
            r_y_d0     <= r_y;
            r_z_d0     <= r_z;
            r_valid_d0 <= r_valid;
            -- Calculate round(a_z / ln2) pt2
            v_range_n_shift := shift_right(r_range_n_mult + resize(C_ROUND_ADD, r_range_n_mult'length), 2 * G_DATA_WIDTH_FRAC);
            r_range_n <= v_range_n_shift(r_range_n'range);
            -------------
            -- PIPE 2
            -------------
            r_x_d1       <= r_x_d0;
            r_y_d1       <= r_y_d0;
            r_z_d1       <= r_z_d0;
            r_valid_d1   <= r_valid_d0;
            r_range_n_d0 <= r_range_n;
            r_subtract   <= r_range_n * C_LN2_SIGNED;
            -------------
            -- PIPE 3
            -------------
            r_x_d2       <= r_x_d1;
            r_y_d2       <= r_y_d1;
            r_valid_d2   <= r_valid_d1;
            r_range_n_d1 <= r_range_n_d0;
            v_subtract_shift := shift_right(r_subtract, G_DATA_WIDTH_FRAC);
            r_range_r <= resize(signed(r_z_d1), r_subtract'length) - r_subtract;
        end if;
    end process p_range_reduce;
    -- ===================================================================
end architecture;