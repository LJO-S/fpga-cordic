
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

entity range_reduce_tb is
    generic (
        runner_cfg          : string;
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_RANGE_N_WIDTH     : natural := 10
    );
end;

architecture bench of range_reduce_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    -- Generics
    -- Ports
    signal clk     : std_logic := '0';
    signal i_x     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_y     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_z     : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_valid : std_logic;
    signal o_x     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_y     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_r     : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_n     : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
    signal o_valid : std_logic;
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
    signal auto_data_tvalid       : std_logic;

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
        variable v_data_x : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_data_y : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_data_z : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    begin
        tb_auto_done <= false;
        wait until tb_auto_set = TRUE;
        while not endfile(v_read_file) loop
            readline(v_read_file, v_line);
            BINARY_READ(v_line, v_data_x);
            BINARY_READ(v_line, v_data_y);
            BINARY_READ(v_line, v_data_z);
            auto_data_x      <= v_data_x;
            auto_data_y      <= v_data_y;
            auto_data_z      <= v_data_z;
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
                write(v_line, o_r, right, o_r'length + 4);
                write(v_line, o_n, right, o_n'length + 4);
                -- Write to file
                writeline(v_write_file, v_line);
            end if;
        end if;
    end process p_write_output_file;
    -- ===================================================================
    i_x     <= auto_data_x;
    i_y     <= auto_data_y;
    i_z     <= auto_data_z;
    i_valid <= auto_data_tvalid;
    -- ===================================================================
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
            i_x     => i_x,
            i_y     => i_y,
            i_z     => i_z,
            i_valid => i_valid,
            o_x     => o_x,
            o_y     => o_y,
            o_r     => o_r,
            o_n     => o_n,
            o_valid => o_valid
        );
    -- ===================================================================
    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
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
    tb_output_data_r_float <= real(to_integer(signed(o_r))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_n_int   <= to_integer(signed(o_n));
    -- ===================================================================
end;