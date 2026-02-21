library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity cordic is
    generic (
        G_DATA_WIDTH       : natural := 32;
        G_DATA_WIDTH_FRAC  : natural := 23;
        G_NBR_OF_FUNCTIONS : natural := 20
    );
    port (
        clk : in std_logic;
        -- Config
        i_config_tdata  : in std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        i_config_tvalid : in std_logic;
        o_config_tready : out std_logic;
        -- Input data
        i_data_x      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_y      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_z      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_data_tvalid : in std_logic;
        o_data_tready : out std_logic;
        -- Output data
        o_data_x      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_y      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_z      : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_data_tvalid : out std_logic
    );
end entity cordic;

architecture rtl of cordic is
    ----------------
    -- Constants
    ----------------
    ----------------
    -- Types
    ----------------
    ----------------
    -- Functions
    ----------------
    ----------------
    -- Signals
    ----------------
begin
    -- ===================================================================
    -- Combinatorial
    -- ===================================================================
    cordic_core_inst : entity work.cordic_core
        generic map(
            G_NBR_OF_FUNCTIONS  => G_NBR_OF_FUNCTIONS,
            G_NBR_OF_ITERATIONS => G_NBR_OF_ITERATIONS,
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => G_RANGE_N_WIDTH
        )
        port map
        (
            clk => clk,
            -- Microcode
            i_config_data     => i_config_data,
            i_config_valid    => i_config_valid,
            o_config_ready    => o_config_ready,
            o_microcode_data  => o_microcode_data,
            o_microcode_valid => o_microcode_valid,
            i_microcode_data  => i_microcode_data,
            i_microcode_valid => i_microcode_valid,
            -- Mode/Submode
            o_mode    => o_mode,
            o_submode => o_submode,
            -- Input
            i_data_x     => i_data_x,
            i_data_y     => i_data_y,
            i_data_z     => i_data_z,
            i_data_valid => i_data_valid,
            o_data_ready => o_data_ready,
            -- Init 
            o_init_x_input => o_init_x_input,
            o_init_x_prev  => o_init_x_prev,
            o_init_x_type  => o_init_x_type,
            o_init_y_input => o_init_y_input,
            o_init_y_prev  => o_init_y_prev,
            o_init_y_type  => o_init_y_type,
            o_init_z_input => o_init_z_input,
            o_init_z_prev  => o_init_z_prev,
            o_init_z_type  => o_init_z_type,
            o_init_valid   => o_init_valid,
            i_init_x       => i_init_x,
            i_init_y       => i_init_y,
            i_init_z       => i_init_z,
            i_init_valid   => i_init_valid,
            -- Pre-Process
            i_preproc_ready  => i_preproc_ready,
            o_preproc_config => o_preproc_config,
            o_preproc_x      => o_preproc_x,
            o_preproc_y      => o_preproc_y,
            o_preproc_z      => o_preproc_z,
            o_preproc_valid  => o_preproc_valid,
            i_preproc_x      => i_preproc_x,
            i_preproc_y      => i_preproc_y,
            i_preproc_z      => i_preproc_z,
            i_bitshift_x     => i_bitshift_x,
            i_bitshift_y     => i_bitshift_y,
            i_bitshift_z     => i_bitshift_z,
            i_quadrant       => i_quadrant,
            i_range_n        => i_range_n,
            i_preproc_valid  => i_preproc_valid,
            -- Iterator I/O
            i_iterator_x     => i_iterator_x,
            i_iterator_y     => i_iterator_y,
            i_iterator_z     => i_iterator_z,
            i_iterator_valid => i_iterator_valid,
            o_iterator_x     => o_iterator_x,
            o_iterator_y     => o_iterator_y,
            o_iterator_z     => o_iterator_z,
            i_iterator_ready => i_iterator_ready,
            o_iterator_valid => o_iterator_valid,
            -- Post-Process
            i_postproc_ready => i_postproc_ready,
            o_postproc_x     => o_postproc_x,
            o_postproc_y     => o_postproc_y,
            o_postproc_z     => o_postproc_z,
            o_postproc_meta  => o_postproc_meta,
            o_postproc_valid => o_postproc_valid,
            i_postproc_x     => i_postproc_x,
            i_postproc_y     => i_postproc_y,
            i_postproc_z     => i_postproc_z,
            i_postproc_valid => i_postproc_valid,
            -- Output
            o_data_x     => o_data_x,
            o_data_y     => o_data_y,
            o_data_z     => o_data_z,
            o_data_valid => o_data_valid
        );
    -- ===================================================================
    cordic_preprocess_inst : entity work.cordic_preprocess
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => G_RANGE_N_WIDTH,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk          => clk,
            i_config     => i_config,
            i_x          => i_x,
            i_y          => i_y,
            i_z          => i_z,
            i_valid      => i_valid,
            o_ready      => o_ready,
            o_x          => o_x,
            o_y          => o_y,
            o_z          => o_z,
            o_bitshift_x => o_bitshift_x,
            o_bitshift_y => o_bitshift_y,
            o_bitshift_z => o_bitshift_z,
            o_quadrant   => o_quadrant,
            o_range_n    => o_range_n,
            i_ready      => i_ready,
            o_valid      => o_valid
        );
    -- ===================================================================
    cordic_initialization_inst : entity work.cordic_initialization
        generic map(
            G_DATA_WIDTH => G_DATA_WIDTH,
            G_FRAC_WIDTH => G_FRAC_WIDTH
        )
        port map
        (
            clk      => clk,
            i_x_in   => i_x_in,
            i_x_prev => i_x_prev,
            i_x_type => i_x_type,
            i_y_in   => i_y_in,
            i_y_prev => i_y_prev,
            i_y_type => i_y_type,
            i_z_in   => i_z_in,
            i_z_prev => i_z_prev,
            i_z_type => i_z_type,
            i_valid  => i_valid,
            o_ready  => o_ready,
            o_x_data => o_x_data,
            o_y_data => o_y_data,
            o_z_data => o_z_data,
            o_valid  => o_valid,
            i_ready  => i_ready
        );
    -- ===================================================================
    iterator_inst : entity work.iterator
        generic map(
            G_DATA_WIDTH          => G_DATA_WIDTH,
            G_DATA_FRAC_WIDTH     => G_DATA_FRAC_WIDTH,
            G_NBR_OF_ITERATIONS   => G_NBR_OF_ITERATIONS,
            G_INIT_FILEPATH_CIRC  => G_INIT_FILEPATH_CIRC,
            G_INIT_FILEPATH_HYPER => G_INIT_FILEPATH_HYPER
        )
        port map
        (
            clk           => clk,
            i_mode        => i_mode,
            i_submode     => i_submode,
            i_data_x      => i_data_x,
            i_data_y      => i_data_y,
            i_data_z      => i_data_z,
            i_data_tvalid => i_data_tvalid,
            o_data_x      => o_data_x,
            o_data_y      => o_data_y,
            o_data_z      => o_data_z,
            o_data_tvalid => o_data_tvalid
        );
    -- ===================================================================
    cordic_postprocess_inst : entity work.cordic_postprocess
        generic map(
            G_DATA_WIDTH_DENORM => G_DATA_WIDTH_DENORM,
            G_DATA_WIDTH_NORM   => G_DATA_WIDTH_NORM,
            G_DATA_WIDTH_FRAC   => G_DATA_WIDTH_FRAC,
            G_SHIFT_WIDTH       => G_SHIFT_WIDTH,
            G_RANGE_N_WIDTH     => G_RANGE_N_WIDTH,
            G_PI_FILEPATH       => G_PI_FILEPATH
        )
        port map
        (
            clk          => clk,
            i_config     => i_config,
            i_mode       => i_mode,
            i_submode    => i_submode,
            i_bitshift_x => i_bitshift_x,
            i_bitshift_y => i_bitshift_y,
            i_bitshift_z => i_bitshift_z,
            i_quadrant   => i_quadrant,
            i_range_n    => i_range_n,
            i_x          => i_x,
            i_y          => i_y,
            i_z          => i_z,
            i_valid      => i_valid,
            o_ready      => o_ready,
            o_x          => o_x,
            o_y          => o_y,
            o_z          => o_z,
            i_ready      => i_ready,
            o_valid      => o_valid
        );
    -- ===================================================================
    -- Memory TODO
    -- ===================================================================
end architecture;