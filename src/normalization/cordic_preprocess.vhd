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
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_SHIFT_WIDTH       : natural := 5;
        G_RANGE_N_WIDTH     : natural := 10;
        G_PI_FILEPATH       : string  := "../../data/pi_" & integer'image(G_DATA_WIDTH_DENORM) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt"
    );
    port (
        clk : in std_logic;
        -- Configuration
        i_config : in t_normalization;
        -- Input Data
        i_x     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_valid : in std_logic;
        o_ready : out std_logic;
        -- Output Data
        o_x          : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_y          : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_z          : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_bitshift_x : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_bitshift_y : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_bitshift_z : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_quadrant   : out std_logic_vector(1 downto 0);
        o_range_n    : out std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
        i_ready      : in std_logic;
        o_valid      : out std_logic
    );
end entity cordic_preprocess;

architecture rtl of cordic_preprocess is
    ----------------
    --  Functions
    ----------------

    ----------------
    -- Constants
    ----------------

    ----------------
    -- Types
    ----------------
    type t_preproc_state is (IDLE, CHECK, BITSHIFT, RANGE_REDUCE, QUADRANT_MAP);
    signal s_preproc_state : t_preproc_state := IDLE;
    ----------------
    -- Signals
    ----------------
    signal r_x      : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_y      : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_z      : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_config : t_normalization;
    -- Status
    signal r_valid_out : std_logic := '0';
    -- Config
    signal w_norm_input  : std_logic_vector(r_config.norm_input'range);
    signal w_norm_common : std_logic;
    signal w_norm_double : std_logic;
    -- Bitshift
    signal r_bitshift_valid_in    : std_logic := '0';
    signal w_bitshift_valid_out   : std_logic;
    signal w_bitshift_x_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_bitshift_y_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_bitshift_z_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_bitshift_x_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal w_bitshift_y_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal w_bitshift_z_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal r_bitshift_x_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
    signal r_bitshift_y_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
    signal r_bitshift_z_shift_out : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
    -- Range Reduce
    signal r_reduce_valid_in    : std_logic := '0';
    signal w_reduce_valid_out   : std_logic;
    signal w_reduce_x_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_reduce_y_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_reduce_z_out       : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_reduce_n_shift_out : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
    signal r_reduce_n_shift_out : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');
    -- Quadrant Map
    signal r_quadrant_valid_in  : std_logic := '0';
    signal w_quadrant_valid_out : std_logic;
    signal w_quadrant_x_out     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_quadrant_y_out     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_quadrant_z_out     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal w_quadrant_out       : std_logic_vector(1 downto 0);
    signal r_quadrant_out       : std_logic_vector(1 downto 0) := (others => '0');

begin
    -- ===================================================================
    -- Combinatorial
    o_ready <= '1' when (s_preproc_state = IDLE) else
        '0';
    o_valid      <= r_valid_out;
    o_x          <= std_logic_vector(r_x(o_x'range));
    o_y          <= std_logic_vector(r_y(o_y'range));
    o_z          <= std_logic_vector(r_z(o_z'range));
    o_bitshift_x <= r_bitshift_x_shift_out;
    o_bitshift_y <= r_bitshift_y_shift_out;
    o_bitshift_z <= r_bitshift_z_shift_out;
    o_range_n    <= r_reduce_n_shift_out;
    o_quadrant   <= r_quadrant_out;
    -- Internals
    w_norm_input  <= r_config.norm_input;
    w_norm_common <= r_config.norm_common;
    w_norm_double <= r_config.norm_shift_double;
    -- ===================================================================
    p_ctrl_fsm : process (clk)
    begin
        if rising_edge(clk) then
            -- Default
            r_valid_out         <= '0';
            r_bitshift_valid_in <= '0';
            r_reduce_valid_in   <= '0';
            r_quadrant_valid_in <= '0';
            -- FSM
            case s_preproc_state is
                    ----------------------------------------------------------
                when IDLE =>
                    if (i_valid = '1') then
                        r_x             <= signed(i_x);
                        r_y             <= signed(i_y);
                        r_z             <= signed(i_z);
                        r_config        <= i_config;
                        s_preproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when CHECK =>
                    if (r_config.norm_en = '1') then
                        r_bitshift_valid_in <= '1';
                        s_preproc_state     <= BITSHIFT;
                    elsif (r_config.reduction_en = '1') then
                        r_reduce_valid_in <= '1';
                        s_preproc_state   <= RANGE_REDUCE;
                    elsif (r_config.quadrant_en = '1') then
                        r_quadrant_valid_in <= '1';
                        s_preproc_state     <= QUADRANT_MAP;
                    else
                        r_valid_out <= '1';
                        if (i_ready = '1') then
                            s_preproc_state <= IDLE;
                        end if;
                    end if;
                    ----------------------------------------------------------
                when BITSHIFT =>
                    if (w_bitshift_valid_out = '1') then
                        r_config.norm_en       <= '0';
                        r_x                    <= resize(signed(w_bitshift_x_out), r_x'length);
                        r_y                    <= resize(signed(w_bitshift_y_out), r_y'length);
                        r_z                    <= resize(signed(w_bitshift_z_out), r_z'length);
                        r_bitshift_x_shift_out <= w_bitshift_x_shift_out;
                        r_bitshift_y_shift_out <= w_bitshift_y_shift_out;
                        r_bitshift_z_shift_out <= w_bitshift_z_shift_out;
                        s_preproc_state        <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when RANGE_REDUCE =>
                    if (w_reduce_valid_out = '1') then
                        r_config.reduction_en <= '0';
                        r_x                   <= resize(signed(w_reduce_x_out), r_x'length);
                        r_y                   <= resize(signed(w_reduce_y_out), r_y'length);
                        r_z                   <= resize(signed(w_reduce_z_out), r_z'length);
                        r_reduce_n_shift_out  <= w_reduce_n_shift_out;
                        s_preproc_state       <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when QUADRANT_MAP =>
                    if (w_quadrant_valid_out = '1') then
                        r_config.quadrant_en <= '0';
                        r_x                  <= resize(signed(w_quadrant_x_out), r_x'length);
                        r_y                  <= resize(signed(w_quadrant_y_out), r_y'length);
                        r_z                  <= resize(signed(w_quadrant_z_out), r_z'length);
                        r_quadrant_out       <= w_quadrant_out;
                        s_preproc_state      <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when others =>
                    s_preproc_state <= IDLE;
                    ----------------------------------------------------------
            end case;
        end if;
    end process p_ctrl_fsm;

    -- ===================================================================
    -- Bitshift normalization
    -- Shift down to [1,2)
    bitshift_norm_inst : entity work.bitshift_norm
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH
        )
        port map
        (
            clk            => clk,
            i_shift_double => w_norm_double,
            i_shift_common => w_norm_common,
            i_shift_inputs => w_norm_input,
            i_x            => std_logic_vector(r_x),
            i_y            => std_logic_vector(r_y),
            i_z            => std_logic_vector(r_z),
            i_valid        => r_bitshift_valid_in,
            o_x            => w_bitshift_x_out,
            o_y            => w_bitshift_y_out,
            o_z            => w_bitshift_z_out,
            o_x_shift      => w_bitshift_x_shift_out,
            o_y_shift      => w_bitshift_y_shift_out,
            o_z_shift      => w_bitshift_z_shift_out,
            o_valid        => w_bitshift_valid_out
        );
    -- ===================================================================
    -- Range Reduction
    -- Reduce angle z to the primary interval r in [-ln2/2, ln2/2] (or similar).
    -- This variant reduces by integer multiples of ln(2): z = r + n*ln2
    range_reduce_inst : entity work.range_reduce
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_RANGE_N_WIDTH     => G_RANGE_N_WIDTH
        )
        port map
        (
            clk     => clk,
            i_x     => std_logic_vector(r_x),
            i_y     => std_logic_vector(r_y),
            i_z     => std_logic_vector(r_z),
            i_valid => r_reduce_valid_in,
            o_x     => w_reduce_x_out,
            o_y     => w_reduce_y_out,
            o_r     => w_reduce_z_out,
            o_n     => w_reduce_n_shift_out,
            o_valid => w_reduce_valid_out
        );
    -- ===================================================================
    -- Quadrant Mapping
    -- Maps angle z into the principal quadrant [0, pi/2).
    quadrant_map_inst : entity work.quadrant_map
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk        => clk,
            i_x        => std_logic_vector(r_x),
            i_y        => std_logic_vector(r_y),
            i_z        => std_logic_vector(r_z),
            i_valid    => r_quadrant_valid_in,
            o_x        => w_quadrant_x_out,
            o_y        => w_quadrant_y_out,
            o_z        => w_quadrant_z_out,
            o_quadrant => w_quadrant_out,
            o_valid    => w_quadrant_valid_out
        );
    -- ===================================================================
end architecture;