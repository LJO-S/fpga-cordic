library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity cordic_postprocess is
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
        i_config     : in t_normalization;

        i_bitshift_x : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_bitshift_y : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_bitshift_z : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_quadrant   : in std_logic_vector(1 downto 0);
        i_range_n    : in std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
        -- Input Data
        i_x     : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_y     : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_z     : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_valid : in std_logic;
        o_ready : out std_logic;
        -- Output Data
        o_x     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_z     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_ready : in std_logic;
        o_valid : out std_logic
    );
end entity cordic_postprocess;

architecture rtl of cordic_postprocess is
    ----------------
    --  Functions
    ----------------

    ----------------
    -- Constants
    ----------------

    ----------------
    -- Types
    ----------------
    type t_postproc_state is (IDLE, CHECK, BITSHIFT, RANGE_REDUCE, QUADRANT_MAP);
    ----------------
    -- Signals
    ----------------
    signal s_postproc_state : t_postproc_state := IDLE;

    signal r_x      : signed(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_y      : signed(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_z      : signed(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
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
    p_ctrl_fsm : process (clk)
    begin
        if rising_edge(clk) then
            -- Default

            case s_postproc_state is
                when IDLE =>
                    if (i_valid = '1') then
                        r_x              <= signed(i_x);
                        r_y              <= signed(i_y);
                        r_z              <= signed(i_z);
                        r_config         <= i_config;
                        s_postproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when CHECK =>
                    if (r_config.norm_en = '1') then
                        r_bitshift_valid_in <= '1';
                        s_postproc_state    <= BITSHIFT;
                    elsif (r_config.reduction_en = '1') then
                        r_reduce_valid_in <= '1';
                        s_postproc_state  <= RANGE_REDUCE;
                    elsif (r_config.quadrant_en = '1') then
                        r_quadrant_valid_in <= '1';
                        s_postproc_state    <= QUADRANT_MAP;
                    else
                        r_valid_out <= '1';
                        if (i_ready = '1') then
                            s_postproc_state <= IDLE;
                        end if;
                    end if;
                    ----------------------------------------------------------
                when BITSHIFT =>
                    if (w_bitshift_valid_out = '1') then
                        null;
                    end if;
                    ----------------------------------------------------------
                when RANGE_REDUCE =>
                    if (w_reduce_valid_out = '1') then
                        null;
                    end if;
                    ----------------------------------------------------------
                when QUADRANT_MAP =>
                    if (w_quadrant_valid_out = '1') then
                        null;
                    end if;
                    ----------------------------------------------------------
                when others =>
                    s_postproc_state <= IDLE;
                    ----------------------------------------------------------
            end case;
        end if;
    end process p_ctrl_fsm;
    -- ===================================================================
end architecture;