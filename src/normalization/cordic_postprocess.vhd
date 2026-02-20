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
        i_config  : in t_normalization;
        i_mode    : in t_mode;
        i_submode : in t_submode;
        -- Meta
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
    type t_postproc_state is (IDLE, CHECK, BITSHIFT, RANGE_REDUCE, QUADRANT_MAP, DONE);
    ----------------
    -- Signals
    ----------------
    signal s_postproc_state : t_postproc_state := IDLE;

    signal r_x : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_y : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_z : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    -- Config
    signal r_config  : t_normalization;
    signal r_mode    : t_mode;
    signal r_submode : t_submode;
    -- Status
    signal w_valid_out : std_logic;
    -- Bitshift
    signal r_bitshift_x_bitshift_in : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal r_bitshift_y_bitshift_in : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal r_bitshift_z_bitshift_in : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal r_bitshift_valid_in      : std_logic;
    signal w_bitshift_x_out         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_bitshift_y_out         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_bitshift_z_out         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_bitshift_valid_out     : std_logic;
    -- Range Reduce
    signal r_range_reduce_range_n_in : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
    signal r_range_reduce_valid_in   : std_logic;
    signal w_range_reduce_x_out      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_range_reduce_y_out      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_range_reduce_z_out      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_range_reduce_valid_out  : std_logic;
    -- Quadrant Map
    signal r_quad_map_in        : std_logic_vector(1 downto 0);
    signal r_quad_map_valid_in  : std_logic;
    signal w_quad_map_x_out     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_quad_map_y_out     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_quad_map_z_out     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_quad_map_valid_out : std_logic;

begin
    -- ===================================================================
    o_ready <= '1' when (s_postproc_state = IDLE) else
        '0';
    o_x     <= std_logic_vector(r_x);
    o_y     <= std_logic_vector(r_y);
    o_z     <= std_logic_vector(r_z);
    o_valid <= '1' when (s_postproc_state = DONE) else
        '0';
    -- ===================================================================
    p_ctrl_fsm : process (clk)
    begin
        if rising_edge(clk) then
            -- Default
            r_bitshift_valid_in     <= '0';
            r_range_reduce_valid_in <= '0';
            r_quad_map_valid_in     <= '0';

            -- FSM
            case s_postproc_state is
                when IDLE =>
                    r_x                       <= resize(signed(i_x), G_DATA_WIDTH_DENORM);
                    r_y                       <= resize(signed(i_y), G_DATA_WIDTH_DENORM);
                    r_z                       <= resize(signed(i_z), G_DATA_WIDTH_DENORM);
                    r_bitshift_x_bitshift_in  <= i_bitshift_x;
                    r_bitshift_y_bitshift_in  <= i_bitshift_y;
                    r_bitshift_z_bitshift_in  <= i_bitshift_z;
                    r_range_reduce_range_n_in <= i_range_n;
                    r_quad_map_in             <= i_quadrant;
                    r_config                  <= i_config;
                    r_mode                    <= i_mode;
                    r_submode                 <= i_submode;
                    if (i_valid = '1') then
                        s_postproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when CHECK =>
                    if (r_config.norm_en = '1') then
                        r_bitshift_valid_in <= '1';
                        s_postproc_state    <= BITSHIFT;
                    elsif (r_config.reduction_en = '1') then
                        r_range_reduce_valid_in <= '1';
                        s_postproc_state        <= RANGE_REDUCE;
                    elsif (r_config.quadrant_en = '1') then
                        r_quad_map_valid_in <= '1';
                        s_postproc_state    <= QUADRANT_MAP;
                    else
                        s_postproc_state <= DONE;
                    end if;
                    ----------------------------------------------------------
                when BITSHIFT =>
                    r_config.norm_en <= '0';
                    if (w_bitshift_valid_out = '1') then
                        r_x              <= signed(w_bitshift_x_out);
                        r_y              <= signed(w_bitshift_y_out);
                        r_z              <= signed(w_bitshift_z_out);
                        s_postproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when RANGE_REDUCE =>
                    r_config.reduction_en <= '0';
                    if (w_range_reduce_valid_out = '1') then
                        r_x              <= signed(w_range_reduce_x_out);
                        r_y              <= signed(w_range_reduce_y_out);
                        r_z              <= signed(w_range_reduce_z_out);
                        s_postproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when QUADRANT_MAP =>
                    r_config.quadrant_en <= '0';
                    if (w_quad_map_valid_out = '1') then
                        r_x              <= signed(w_quad_map_x_out);
                        r_y              <= signed(w_quad_map_y_out);
                        r_z              <= signed(w_quad_map_z_out);
                        s_postproc_state <= CHECK;
                    end if;
                    ----------------------------------------------------------
                when DONE =>
                    if (i_ready = '1') then
                        s_postproc_state <= IDLE;
                    end if;
                    ----------------------------------------------------------
                when others =>
                    s_postproc_state <= IDLE;
                    ----------------------------------------------------------
            end case;
        end if;
    end process p_ctrl_fsm;
    -- ===================================================================
    postproc_bitshift_inst : entity work.postproc_bitshift
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH
        )
        port map
        (
            clk          => clk,
            i_config     => r_config,
            i_mode       => r_mode,
            i_submode    => r_submode,
            i_x          => std_logic_vector(r_x),
            i_y          => std_logic_vector(r_y),
            i_z          => std_logic_vector(r_z),
            i_bitshift_x => r_bitshift_x_bitshift_in,
            i_bitshift_y => r_bitshift_y_bitshift_in,
            i_bitshift_z => r_bitshift_z_bitshift_in,
            i_valid      => r_bitshift_valid_in,
            o_x          => w_bitshift_x_out,
            o_y          => w_bitshift_y_out,
            o_z          => w_bitshift_z_out,
            o_valid      => w_bitshift_valid_out
        );
    -- ===================================================================
    postproc_range_reduce_inst : entity work.postproc_range_reduce
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => G_RANGE_N_WIDTH
        )
        port map
        (
            clk          => clk,
            i_config     => r_config,
            i_mode       => r_mode,
            i_submode    => r_submode,
            i_x          => std_logic_vector(r_x),
            i_y          => std_logic_vector(r_y),
            i_z          => std_logic_vector(r_z),
            i_bitshift_x => r_bitshift_x_bitshift_in,
            i_range_n    => r_range_reduce_range_n_in,
            i_valid      => r_range_reduce_valid_in,
            o_x          => w_range_reduce_x_out,
            o_y          => w_range_reduce_y_out,
            o_z          => w_range_reduce_z_out,
            o_valid      => w_range_reduce_valid_out
        );

    -- ===================================================================
    postproc_quadrant_map_inst : entity work.postproc_quadrant_map
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk        => clk,
            i_x        => std_logic_vector(r_x),
            i_y        => std_logic_vector(r_y),
            i_z        => std_logic_vector(r_z),
            i_quadrant => r_quad_map_in,
            i_valid    => r_quad_map_valid_in,
            o_x        => w_quad_map_x_out,
            o_y        => w_quad_map_y_out,
            o_z        => w_quad_map_z_out,
            o_valid    => w_quad_map_valid_out
        );
    -- ===================================================================
end architecture;