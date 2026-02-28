library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
use work.cordic_microcode_pkg.all;
-- 
entity cordic is
    generic (
        -- Input data total width
        G_DATA_WIDTH : natural := 32;
        -- Input data fractional width
        G_DATA_WIDTH_FRAC : natural := 23;
        -- Number of CORDIC iterations
        G_NBR_OF_ITERATIONS : natural := 40;
        -- FILEPATHS
        G_PI_FILEPATH         : string := "../../data/pi_" & integer'image(G_DATA_WIDTH) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt";
        G_INIT_FILEPATH_CIRC  : string := "../../data/angle_circ_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt";
        G_INIT_FILEPATH_HYPER : string := "../../data/angle_hyper_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt"

    );
    port (
        clk : in std_logic;
        -- Config
        i_config_data  : in std_logic_vector(integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        i_config_valid : in std_logic;
        o_config_ready : out std_logic;
        -- Input data
        i_data_x     : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_y     : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_z     : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_valid : in std_logic;
        o_data_ready : out std_logic;
        -- Output data
        o_data_x     : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_y     : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_z     : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_valid : out std_logic
    );
end entity cordic;

architecture rtl of cordic is
    ----------------
    -- Constants
    ----------------
    constant C_DATA_WIDTH_DENORM : natural := G_DATA_WIDTH;
    constant C_DATA_WIDTH_NORM   : natural := G_DATA_WIDTH_FRAC + 2;
    -- constant C_SHIFT_WIDTH       : natural := integer(ceil(log2(real(2 + C_DATA_WIDTH_DENORM - C_DATA_WIDTH_NORM))));
    constant C_SHIFT_WIDTH   : natural := 5;
    constant C_RANGE_N_WIDTH : natural := integer(ceil(log2(ceil((2.0 ** (C_DATA_WIDTH_DENORM - 1 - G_DATA_WIDTH_FRAC)) / MATH_LOG_OF_2))));

    ----------------
    -- Types
    ----------------
    ----------------
    -- Functions
    ----------------
    ----------------
    -- Signals
    ----------------

    -- CORDIC CORE
    -- Microcode
    signal w_cordic_config_ready_out  : std_logic;
    signal w_rom_to_cordic_step_data  : t_step;
    signal w_rom_to_cordic_step_valid : std_logic;
    signal w_cordic_to_rom_step_re    : std_logic;
    signal w_cordic_to_rom_step_raddr : std_logic_vector(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0);

    signal w_cordic_mode    : t_mode;
    signal w_cordic_submode : t_submode;
    signal w_cordic_norm    : t_normalization;
    -- Input
    signal w_cordic_data_ready_out : std_logic;
    -- Init
    signal w_cordic_to_init_x_input : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_x_prev  : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_x_type  : t_initialization_type;
    signal w_cordic_to_init_y_input : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_y_prev  : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_y_type  : t_initialization_type;
    signal w_cordic_to_init_z_input : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_z_prev  : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_init_z_type  : t_initialization_type;
    signal w_cordic_to_init_valid   : std_logic;
    signal w_init_to_cordic_x       : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_init_to_cordic_y       : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_init_to_cordic_z       : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_init_to_cordic_valid   : std_logic;
    -- Preproc
    signal w_preproc_to_cordic_ready      : std_logic;
    signal w_cordic_to_preproc_config     : t_normalization;
    signal w_cordic_to_preproc_config_ovr : t_normalization;
    signal w_cordic_to_preproc_x          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_preproc_y          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_preproc_z          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_to_preproc_valid      : std_logic;
    signal w_preproc_to_cordic_x          : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_preproc_to_cordic_y          : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_preproc_to_cordic_z          : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_preproc_to_cordic_bitshift_x : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_preproc_to_cordic_bitshift_y : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_preproc_to_cordic_bitshift_z : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_preproc_to_cordic_quadrant   : std_logic_vector(1 downto 0);
    signal w_preproc_to_cordic_range_n    : std_logic_vector(C_RANGE_N_WIDTH - 1 downto 0);
    signal w_preproc_to_cordic_valid      : std_logic;
    -- Iterator
    signal w_iterator_to_cordic_x     : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_iterator_to_cordic_y     : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_iterator_to_cordic_z     : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_iterator_to_cordic_valid : std_logic;
    signal w_cordic_to_iterator_x     : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_cordic_to_iterator_y     : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_cordic_to_iterator_z     : std_logic_vector(C_DATA_WIDTH_NORM - 1 downto 0);
    signal w_cordic_to_iterator_valid : std_logic;
    -- Postproc
    signal w_postproc_to_cordic_ready      : std_logic;
    signal w_cordic_to_postproc_x          : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_cordic_to_postproc_y          : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_cordic_to_postproc_z          : std_logic_vector(C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal w_cordic_to_postproc_bitshift_x : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_cordic_to_postproc_bitshift_y : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_cordic_to_postproc_bitshift_z : std_logic_vector(C_SHIFT_WIDTH - 1 downto 0);
    signal w_cordic_to_postproc_range_n    : std_logic_vector(C_RANGE_N_WIDTH - 1 downto 0);
    signal w_cordic_to_postproc_quadrant   : std_logic_vector(1 downto 0);
    signal w_cordic_to_postproc_valid      : std_logic;
    signal w_postproc_to_cordic_x          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_postproc_to_cordic_y          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_postproc_to_cordic_z          : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_postproc_to_cordic_valid      : std_logic;
    -- Output
    signal w_cordic_out_data_x     : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_out_data_y     : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_out_data_z     : std_logic_vector(C_DATA_WIDTH_DENORM - 1 downto 0);
    signal w_cordic_out_data_valid : std_logic;

begin
    -- ===================================================================
    p_sanity_check : process
    begin
        assert C_DATA_WIDTH_NORM < C_DATA_WIDTH_DENORM
        report "Normalized NOT less than de-normalized! Expected Norm(" &
            integer'image(C_DATA_WIDTH_NORM) &
            ") < (" &
            integer'image(C_DATA_WIDTH_DENORM) &
            ")"
            severity failure;
        wait;
    end process p_sanity_check;
    -- ===================================================================
    -- Combinatorial
    -- In
    o_data_ready   <= w_cordic_data_ready_out;
    o_config_ready <= w_cordic_config_ready_out;
    -- Out
    o_data_x     <= w_cordic_out_data_x;
    o_data_y     <= w_cordic_out_data_y;
    o_data_z     <= w_cordic_out_data_z;
    o_data_valid <= w_cordic_out_data_valid;
    -- ===================================================================
    cordic_core_inst : entity work.cordic_core
        generic map(
            G_NBR_OF_FUNCTIONS  => C_NBR_OF_FUNCTIONS,
            G_NBR_OF_ITERATIONS => G_NBR_OF_ITERATIONS,
            G_DATA_WIDTH_DENORM => C_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => C_DATA_WIDTH_NORM,
            G_SHIFT_WIDTH       => C_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => C_RANGE_N_WIDTH
        )
        port map
        (
            clk => clk,
            -- Configuration
            i_config_data  => i_config_data,
            i_config_valid => i_config_valid,
            o_config_ready => w_cordic_config_ready_out,
            -- Microcode ROM
            i_step_data  => w_rom_to_cordic_step_data,
            i_step_valid => w_rom_to_cordic_step_valid,
            o_step_re    => w_cordic_to_rom_step_re,
            o_step_raddr => w_cordic_to_rom_step_raddr,
            -- Mode
            o_mode     => w_cordic_mode,
            o_submode  => w_cordic_submode,
            o_norm_cfg => w_cordic_norm,
            -- Input
            i_data_x     => i_data_x,
            i_data_y     => i_data_y,
            i_data_z     => i_data_z,
            i_data_valid => i_data_valid,
            o_data_ready => w_cordic_data_ready_out,
            -- Initialization
            o_init_x_input => w_cordic_to_init_x_input,
            o_init_x_prev  => w_cordic_to_init_x_prev,
            o_init_x_type  => w_cordic_to_init_x_type,
            o_init_y_input => w_cordic_to_init_y_input,
            o_init_y_prev  => w_cordic_to_init_y_prev,
            o_init_y_type  => w_cordic_to_init_y_type,
            o_init_z_input => w_cordic_to_init_z_input,
            o_init_z_prev  => w_cordic_to_init_z_prev,
            o_init_z_type  => w_cordic_to_init_z_type,
            o_init_valid   => w_cordic_to_init_valid,
            i_init_x       => w_init_to_cordic_x,
            i_init_y       => w_init_to_cordic_y,
            i_init_z       => w_init_to_cordic_z,
            i_init_valid   => w_init_to_cordic_valid,
            -- Pre-Process
            i_preproc_ready  => w_preproc_to_cordic_ready,
            o_preproc_config => w_cordic_to_preproc_config,
            o_preproc_x      => w_cordic_to_preproc_x,
            o_preproc_y      => w_cordic_to_preproc_y,
            o_preproc_z      => w_cordic_to_preproc_z,
            o_preproc_valid  => w_cordic_to_preproc_valid,
            i_preproc_x      => w_preproc_to_cordic_x,
            i_preproc_y      => w_preproc_to_cordic_y,
            i_preproc_z      => w_preproc_to_cordic_z,
            i_bitshift_x     => w_preproc_to_cordic_bitshift_x,
            i_bitshift_y     => w_preproc_to_cordic_bitshift_y,
            i_bitshift_z     => w_preproc_to_cordic_bitshift_z,
            i_quadrant       => w_preproc_to_cordic_quadrant,
            i_range_n        => w_preproc_to_cordic_range_n,
            i_preproc_valid  => w_preproc_to_cordic_valid,
            -- Iterator
            i_iterator_x     => w_iterator_to_cordic_x,
            i_iterator_y     => w_iterator_to_cordic_y,
            i_iterator_z     => w_iterator_to_cordic_z,
            i_iterator_valid => w_iterator_to_cordic_valid,
            o_iterator_x     => w_cordic_to_iterator_x,
            o_iterator_y     => w_cordic_to_iterator_y,
            o_iterator_z     => w_cordic_to_iterator_z,
            i_iterator_ready => '1',
            o_iterator_valid => w_cordic_to_iterator_valid,
            -- Post-Process
            i_postproc_ready      => w_postproc_to_cordic_ready,
            o_postproc_x          => w_cordic_to_postproc_x,
            o_postproc_y          => w_cordic_to_postproc_y,
            o_postproc_z          => w_cordic_to_postproc_z,
            o_postproc_bitshift_x => w_cordic_to_postproc_bitshift_x,
            o_postproc_bitshift_y => w_cordic_to_postproc_bitshift_y,
            o_postproc_bitshift_z => w_cordic_to_postproc_bitshift_z,
            o_postproc_range_n    => w_cordic_to_postproc_range_n,
            o_postproc_quadrant   => w_cordic_to_postproc_quadrant,
            o_postproc_valid      => w_cordic_to_postproc_valid,
            i_postproc_x          => w_postproc_to_cordic_x,
            i_postproc_y          => w_postproc_to_cordic_y,
            i_postproc_z          => w_postproc_to_cordic_z,
            i_postproc_valid      => w_postproc_to_cordic_valid,
            -- Output
            o_data_x     => w_cordic_out_data_x,
            o_data_y     => w_cordic_out_data_y,
            o_data_z     => w_cordic_out_data_z,
            o_data_valid => w_cordic_out_data_valid
        );
    -- ===================================================================
    w_cordic_to_preproc_config_ovr.norm_en           <= w_cordic_to_preproc_config.norm_en;
    w_cordic_to_preproc_config_ovr.norm_input        <= w_cordic_to_preproc_config.norm_input;
    w_cordic_to_preproc_config_ovr.norm_shift_double <= w_cordic_to_preproc_config.norm_shift_double;
    w_cordic_to_preproc_config_ovr.norm_shift_common <= '1' when (w_cordic_mode = VECTORING) and (w_cordic_submode /= LINEAR) else
    '0';
    w_cordic_to_preproc_config_ovr.reduction_en          <= w_cordic_to_preproc_config.reduction_en;
    w_cordic_to_preproc_config_ovr.reduction_reconstruct <= w_cordic_to_preproc_config.reduction_reconstruct;
    w_cordic_to_preproc_config_ovr.quadrant_en           <= w_cordic_to_preproc_config.quadrant_en;

    cordic_preprocess_inst : entity work.cordic_preprocess
        generic map(
            G_DATA_WIDTH_DENORM => C_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => C_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => C_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => C_RANGE_N_WIDTH,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk          => clk,
            i_config     => w_cordic_to_preproc_config_ovr,
            i_x          => w_cordic_to_preproc_x,
            i_y          => w_cordic_to_preproc_y,
            i_z          => w_cordic_to_preproc_z,
            i_valid      => w_cordic_to_preproc_valid,
            o_ready      => w_preproc_to_cordic_ready,
            o_x          => w_preproc_to_cordic_x,
            o_y          => w_preproc_to_cordic_y,
            o_z          => w_preproc_to_cordic_z,
            o_bitshift_x => w_preproc_to_cordic_bitshift_x,
            o_bitshift_y => w_preproc_to_cordic_bitshift_y,
            o_bitshift_z => w_preproc_to_cordic_bitshift_z,
            o_quadrant   => w_preproc_to_cordic_quadrant,
            o_range_n    => w_preproc_to_cordic_range_n,
            i_ready      => '1',
            o_valid      => w_preproc_to_cordic_valid
        );
    -- ===================================================================
    cordic_initialization_inst : entity work.cordic_initialization
        generic map(
            G_DATA_WIDTH => C_DATA_WIDTH_DENORM,
            G_FRAC_WIDTH => G_DATA_WIDTH_FRAC
        )
        port map
        (
            clk      => clk,
            i_x_in   => w_cordic_to_init_x_input,
            i_x_prev => w_cordic_to_init_x_prev,
            i_x_type => w_cordic_to_init_x_type,
            i_y_in   => w_cordic_to_init_y_input,
            i_y_prev => w_cordic_to_init_y_prev,
            i_y_type => w_cordic_to_init_y_type,
            i_z_in   => w_cordic_to_init_z_input,
            i_z_prev => w_cordic_to_init_z_prev,
            i_z_type => w_cordic_to_init_z_type,
            i_valid  => w_cordic_to_init_valid,
            o_ready  => open,
            o_x_data => w_init_to_cordic_x,
            o_y_data => w_init_to_cordic_y,
            o_z_data => w_init_to_cordic_z,
            o_valid  => w_init_to_cordic_valid,
            i_ready  => '1'
        );
    -- ===================================================================
    iterator_inst : entity work.iterator
        generic map(
            G_DATA_WIDTH          => C_DATA_WIDTH_NORM,
            G_DATA_FRAC_WIDTH     => G_DATA_WIDTH_FRAC,
            G_NBR_OF_ITERATIONS   => G_NBR_OF_ITERATIONS,
            G_INIT_FILEPATH_CIRC  => G_INIT_FILEPATH_CIRC,
            G_INIT_FILEPATH_HYPER => G_INIT_FILEPATH_HYPER
        )
        port map
        (
            clk           => clk,
            i_mode        => w_cordic_mode,
            i_submode     => w_cordic_submode,
            i_data_x      => w_cordic_to_iterator_x,
            i_data_y      => w_cordic_to_iterator_y,
            i_data_z      => w_cordic_to_iterator_z,
            i_data_tvalid => w_cordic_to_iterator_valid,
            o_data_x      => w_iterator_to_cordic_x,
            o_data_y      => w_iterator_to_cordic_y,
            o_data_z      => w_iterator_to_cordic_z,
            o_data_tvalid => w_iterator_to_cordic_valid
        );
    -- ===================================================================
    cordic_postprocess_inst : entity work.cordic_postprocess
        generic map(
            G_DATA_WIDTH_DENORM => C_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => C_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))),
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => C_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => C_RANGE_N_WIDTH,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk          => clk,
            i_config     => w_cordic_norm,
            i_mode       => w_cordic_mode,
            i_submode    => w_cordic_submode,
            i_bitshift_x => w_cordic_to_postproc_bitshift_x,
            i_bitshift_y => w_cordic_to_postproc_bitshift_y,
            i_bitshift_z => w_cordic_to_postproc_bitshift_z,
            i_quadrant   => w_cordic_to_postproc_quadrant,
            i_range_n    => w_cordic_to_postproc_range_n,
            i_x          => w_cordic_to_postproc_x,
            i_y          => w_cordic_to_postproc_y,
            i_z          => w_cordic_to_postproc_z,
            i_valid      => w_cordic_to_postproc_valid,
            o_ready      => w_postproc_to_cordic_ready,
            o_x          => w_postproc_to_cordic_x,
            o_y          => w_postproc_to_cordic_y,
            o_z          => w_postproc_to_cordic_z,
            i_ready      => '1',
            o_valid      => w_postproc_to_cordic_valid
        );
    -- ===================================================================
    -- Memory 
    microcode_rom_wrapper_inst : entity work.microcode_rom_wrapper
        port map
        (
            clk     => clk,
            i_re    => w_cordic_to_rom_step_re,
            i_raddr => w_cordic_to_rom_step_raddr,
            o_data  => w_rom_to_cordic_step_data,
            o_valid => w_rom_to_cordic_step_valid
        );

    -- ===================================================================
end architecture;