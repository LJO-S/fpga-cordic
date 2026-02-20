
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- 
use std.textio.all;
-- 
use work.cordic_pkg.all;
use work.tb_pkg.all;
--
library vunit_lib;
context vunit_lib.vunit_context;

entity cordic_postprocess_tb is
    generic (
        runner_cfg     : string;
        encoded_tb_cfg : string;
        G_PI_FILEPATH  : string := output_path(runner_cfg) & "/pi_" & integer'image(G_DATA_WIDTH_DENORM) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt"
    );
end;

architecture bench of cordic_postprocess_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    -- Vunit config 
    type t_tb_cfg is record
        norm_en               : string;
        norm_input            : string;
        norm_shift_double     : string;
        reduction_en          : string;
        reduction_reconstruct : string;
        quadrant_en           : string;
        G_MODE                : string;
        G_SUBMODE             : string;
        G_DATA_WIDTH_DENORM   : string;
        G_DATA_WIDTH_NORM     : string;
        G_DATA_WIDTH_FRAC     : string;
        G_SHIFT_WIDTH         : string;
        G_RANGE_N_WIDTH       : string;
    end record t_tb_cfg;

    impure function decode (encoded_tb_config : string) return t_tb_cfg is
    begin
        return(
        norm_en               => string(get(encoded_tb_config, "norm_en")),
        norm_input            => string(get(encoded_tb_config, "norm_input")),
        norm_shift_double     => string(get(encoded_tb_config, "norm_shift_double")),
        reduction_en          => string(get(encoded_tb_config, "reduction_en")),
        reduction_reconstruct => string(get(encoded_tb_config, "reduction_reconstruct")),
        quadrant_en           => string(get(encoded_tb_config, "quadrant_en")),
        G_MODE                => string(get(encoded_tb_config, "G_MODE")),
        G_SUBMODE             => string(get(encoded_tb_config, "G_SUBMODE")),
        G_DATA_WIDTH_DENORM   => string(get(encoded_tb_config, "G_DATA_WIDTH_DENORM")),
        G_DATA_WIDTH_NORM     => string(get(encoded_tb_config, "G_DATA_WIDTH_NORM")),
        G_DATA_WIDTH_FRAC     => string(get(encoded_tb_config, "G_DATA_WIDTH_FRAC")),
        G_SHIFT_WIDTH         => string(get(encoded_tb_config, "G_SHIFT_WIDTH")),
        G_RANGE_N_WIDTH       => string(get(encoded_tb_config, "G_RANGE_N_WIDTH"))

        );
    end function decode;
    -- Generics
    constant TB_CONFIG           : t_tb_cfg := decode(encoded_tb_cfg);
    constant G_MODE              : natural  := integer'value(TB_CONFIG.G_MODE);
    constant G_SUBMODE           : natural  := integer'value(TB_CONFIG.G_SUBMODE);
    constant G_DATA_WIDTH_DENORM : natural  := integer'value(TB_CONFIG.G_DATA_WIDTH_DENORM);
    constant G_DATA_WIDTH_NORM   : natural  := integer'value(TB_CONFIG.G_DATA_WIDTH_NORM);
    constant G_DATA_WIDTH_FRAC   : natural  := integer'value(TB_CONFIG.G_DATA_WIDTH_FRAC);
    constant G_SHIFT_WIDTH       : natural  := integer'value(TB_CONFIG.G_SHIFT_WIDTH);
    constant G_RANGE_N_WIDTH     : natural  := integer'value(TB_CONFIG.G_RANGE_N_WIDTH);
    -- Ports
    signal clk          : std_logic;
    signal i_config     : t_normalization;
    signal i_mode       : t_mode;
    signal i_submode    : t_submode;
    signal i_bitshift_x : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal i_bitshift_y : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal i_bitshift_z : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal i_quadrant   : std_logic_vector(1 downto 0);
    signal i_range_n    : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
    signal i_x          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal i_y          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal i_z          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal i_valid      : std_logic;
    signal o_ready      : std_logic;
    signal o_x          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal o_y          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal o_z          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_ready      : std_logic;
    signal o_valid      : std_logic;
    -- Testbench
    signal tb_input_data_x_float  : real    := 0.0;
    signal tb_input_data_y_float  : real    := 0.0;
    signal tb_input_data_z_float  : real    := 0.0;
    signal tb_output_data_x_float : real    := 0.0;
    signal tb_output_data_y_float : real    := 0.0;
    signal tb_output_data_r_float : real    := 0.0;
    signal tb_output_data_n_int   : integer := 0;
    signal tb_auto_set            : boolean := false;
    signal tb_auto_done           : boolean := false;
    signal auto_data_x            : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_data_y            : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_data_z            : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_shift_x           : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_shift_y           : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_shift_z           : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_range_n           : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_quadrant          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal auto_data_tvalid       : std_logic;
    -- Procedure
    procedure wait_clock (clk_ticks : integer) is
    begin
        for i in 0 to clk_ticks - 1 loop
            wait until rising_edge(clk);
        end loop;
    end procedure;
begin
    -- ===================================================================
    clk <= not clk after clk_period/2;
    -- ===================================================================
    -- Read input file
    p_read_input_file : process
        file v_read_file    : text open read_mode is output_path(runner_cfg) & "/" & "input_data.txt";
        variable v_line     : line;
        variable v_data_x   : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_data_y   : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_data_z   : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_shift_x  : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_shift_y  : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_shift_z  : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_range_n  : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_quadrant : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    begin
        tb_auto_done <= false;
        wait until tb_auto_set = TRUE;
        while not endfile(v_read_file) loop
            readline(v_read_file, v_line);
            -- Data
            BINARY_READ(v_line, v_data_x);
            BINARY_READ(v_line, v_data_y);
            BINARY_READ(v_line, v_data_z);
            BINARY_READ(v_line, v_shift_x);
            BINARY_READ(v_line, v_shift_y);
            BINARY_READ(v_line, v_shift_z);
            BINARY_READ(v_line, v_range_n);
            BINARY_READ(v_line, v_quadrant);
            auto_data_x      <= v_data_x;
            auto_data_y      <= v_data_y;
            auto_data_z      <= v_data_z;
            auto_range_n     <= v_range_n;
            auto_shift_x     <= v_shift_x;
            auto_shift_y     <= v_shift_y;
            auto_shift_z     <= v_shift_z;
            auto_data_tvalid <= '1';
            wait_clock(1);
            auto_data_x      <= (others => '0');
            auto_data_y      <= (others => '0');
            auto_data_z      <= (others => '0');
            auto_data_tvalid <= '0';
            wait until o_valid = '1';
            wait_clock(2);
        end loop;
        tb_auto_done <= true;
        wait;
    end process p_read_input_file;
    -- ===================================================================
    -- Write output file
    p_write_output_file : process (clk)
        file v_write_file : text open write_mode is output_path(runner_cfg) & "/" & "output_data.txt";
        variable v_line   : line;
    begin
        if rising_edge(clk) then
            if (o_valid = '1') then
                -- Write output obtained
                write(v_line, o_x, right, o_x'length + 4);
                write(v_line, o_y, right, o_y'length + 4);
                write(v_line, o_z, right, o_z'length + 4);
                -- Write to file
                writeline(v_write_file, v_line);
            end if;
        end if;
    end process p_write_output_file;
    -- ===================================================================
    -- Mode
    i_mode <= ROTATIONAL when (G_MODE = 0) else
        VECTORING;
    -- Submode
    i_submode <= HYPERBOLIC when (G_SUBMODE = 0) else
        CIRCULAR when (G_SUBMODE = 1) else
        LINEAR;
    -- Config
    i_config.norm_en               <= integer'value(TB_CONFIG.norm_en);
    i_config.norm_input            <= integer'value(TB_CONFIG.norm_input);
    i_config.norm_shift_double     <= integer'value(TB_CONFIG.norm_shift_double);
    i_config.reduction_en          <= integer'value(TB_CONFIG.reduction_en);
    i_config.reduction_reconstruct <= integer'value(TB_CONFIG.reduction_reconstruct);
    i_config.quadrant_en           <= integer'value(TB_CONFIG.quadrant_en);
    i_x          <= auto_data_x;
    i_y          <= auto_data_y;
    i_z          <= auto_data_z;
    i_bitshift_x <= auto_shift_x(i_bitshift_x'range);
    i_bitshift_y <= auto_shift_y(i_bitshift_y'range);
    i_bitshift_z <= auto_shift_z(i_bitshift_z'range);
    i_range_n    <= auto_range_n(i_range_n'range);
    i_quadrant   <= auto_quadrant(i_quadrant'range);
    i_valid      <= auto_data_tvalid;
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
    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
            info("Hello world!");
            wait until clk = '1';
            tb_auto_set <= true;
            wait until tb_auto_done = true;
        end if;
        test_runner_cleanup(runner);
    end process main;
    -- ===================================================================
    -- Update debugs
    tb_input_data_x_float  <= real(to_integer(signed(i_x))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_input_data_y_float  <= real(to_integer(signed(i_y))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_input_data_z_float  <= real(to_integer(signed(i_z))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_x_float <= real(to_integer(signed(o_x))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_y_float <= real(to_integer(signed(o_y))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_r_float <= real(to_integer(signed(o_z))) / (2.0 ** G_DATA_WIDTH_FRAC);
    -- ===================================================================
end;