library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use std.textio.all;
-- 
use work.cordic_pkg.all;
use work.cordic_microcode_pkg.all;
use work.tb_pkg.all;
--
library vunit_lib;
context vunit_lib.vunit_context;

entity cordic_tb is
    generic (
        runner_cfg          : string;
        G_CONFIG_IDX        : natural;
        G_DATA_WIDTH        : natural;
        G_DATA_WIDTH_FRAC   : natural;
        G_NBR_OF_ITERATIONS : natural
    );
end;

architecture bench of cordic_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    constant C_TIMEOUT  : time := 100 * clk_period;
    -- Generics
    constant G_PI_FILEPATH         : string := output_path(runner_cfg) & "/pi_" & integer'image(G_DATA_WIDTH) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt";
    constant G_INIT_FILEPATH_CIRC  : string := output_path(runner_cfg) & "/angle_circ_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt";
    constant G_INIT_FILEPATH_HYPER : string := output_path(runner_cfg) & "/angle_hyper_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt";
    -- Ports
    signal clk            : std_logic := '0';
    signal i_config_data  : std_logic_vector(integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))) - 1 downto 0);
    signal i_config_valid : std_logic;
    signal o_config_ready : std_logic;
    signal i_data_x       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_y       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_z       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_valid   : std_logic;
    signal o_data_ready   : std_logic;
    signal o_data_x       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_data_y       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_data_z       : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_data_valid   : std_logic;
    -- Testbench
    signal tb_input_data_x_float  : real    := 0.0;
    signal tb_input_data_y_float  : real    := 0.0;
    signal tb_input_data_z_float  : real    := 0.0;
    signal tb_output_data_x_float : real    := 0.0;
    signal tb_output_data_y_float : real    := 0.0;
    signal tb_output_data_z_float : real    := 0.0;
    signal tb_auto_set            : boolean := false;
    signal tb_auto_done           : boolean := false;
    signal auto_data_x            : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal auto_data_y            : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal auto_data_z            : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal auto_data_valid        : std_logic;
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
        file v_read_file  : text open read_mode is output_path(runner_cfg) & "/" & "input_data.txt";
        variable v_line   : line;
        variable v_data_x : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_y : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_z : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    begin
        tb_auto_done <= false;
        wait until tb_auto_set = TRUE;
        while not endfile(v_read_file) loop
            readline(v_read_file, v_line);
            -- Data
            BINARY_READ(v_line, v_data_x);
            BINARY_READ(v_line, v_data_y);
            BINARY_READ(v_line, v_data_z);
            auto_data_x     <= v_data_x;
            auto_data_y     <= v_data_y;
            auto_data_z     <= v_data_z;
            auto_data_valid <= '1';
            wait_clock(1);
            auto_data_x     <= (others => '0');
            auto_data_y     <= (others => '0');
            auto_data_z     <= (others => '0');
            auto_data_valid <= '0';
            wait until o_data_ready = '1';
            wait_clock(2);
        end loop;
        tb_auto_done <= true;
        wait;
    end process p_read_input_file;
    -- ===================================================================
    -- Assign inputs
    i_data_x      <= auto_data_x;
    i_data_y      <= auto_data_y;
    i_data_z      <= auto_data_z;
    i_data_valid  <= auto_data_valid;
    i_config_data <= std_logic_vector(to_unsigned(G_CONFIG_IDX, i_config_data'length));
    -- ===================================================================
    -- Write output file
    p_write_output_file : process (clk)
        file v_write_file : text open write_mode is output_path(runner_cfg) & "/" & "output_data.txt";
        variable v_line   : line;
    begin
        if rising_edge(clk) then
            if (o_data_valid = '1') then
                -- Write output obtained
                write(v_line, o_data_x, right, o_data_x'length + 4);
                write(v_line, o_data_y, right, o_data_y'length + 4);
                write(v_line, o_data_z, right, o_data_z'length + 4);
                -- Write to file
                writeline(v_write_file, v_line);
            end if;
        end if;
    end process p_write_output_file;
    -- ===================================================================
    cordic_inst : entity work.cordic
        generic map(
            G_DATA_WIDTH          => G_DATA_WIDTH,
            G_DATA_WIDTH_FRAC     => G_DATA_WIDTH_FRAC,
            G_NBR_OF_ITERATIONS   => G_NBR_OF_ITERATIONS,
            G_PI_FILEPATH         => G_PI_FILEPATH,
            G_INIT_FILEPATH_CIRC  => G_INIT_FILEPATH_CIRC,
            G_INIT_FILEPATH_HYPER => G_INIT_FILEPATH_HYPER
        )
        port map
        (
            clk            => clk,
            i_config_data  => i_config_data,
            i_config_valid => i_config_valid,
            o_config_ready => o_config_ready,
            i_data_x       => i_data_x,
            i_data_y       => i_data_y,
            i_data_z       => i_data_z,
            i_data_valid   => i_data_valid,
            o_data_ready   => o_data_ready,
            o_data_x       => o_data_x,
            o_data_y       => o_data_y,
            o_data_z       => o_data_z,
            o_data_valid   => o_data_valid
        );
    -- ===================================================================
    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
            info("Hello world!");
            wait until clk = '1';
            -- Configure function
            wait until o_config_ready = '1' for C_TIMEOUT;
            check(o_config_ready = '1', "Never received o_config_ready = '1'");
            i_config_valid <= '1';
            wait_clock(1);
            i_config_valid <= '0';
            wait_clock(1);
            tb_auto_set <= true;
            wait until tb_auto_done = true;
        end if;
        test_runner_cleanup(runner);
    end process main;
    -- ===================================================================
    -- Update debugs
    tb_input_data_x_float  <= real(to_integer(signed(i_data_x))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_input_data_y_float  <= real(to_integer(signed(i_data_y))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_input_data_z_float  <= real(to_integer(signed(i_data_z))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_x_float <= real(to_integer(signed(o_data_x))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_y_float <= real(to_integer(signed(o_data_y))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_z_float <= real(to_integer(signed(o_data_z))) / (2.0 ** G_DATA_WIDTH_FRAC);
    -- ===================================================================
end;