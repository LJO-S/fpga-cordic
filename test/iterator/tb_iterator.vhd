library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
use work.tb_pkg.all;
--
use std.textio.all;
-- 
library vunit_lib;
context vunit_lib.vunit_context;
-- 
library JSON;
context JSON.json_ctx;
-- use work.JSON.all;

entity iterator_tb is
    generic (
        runner_cfg            : string;
        G_TYPE                : string  := "SIN_COS";
        G_WIDTH               : natural := 32;
        G_FRAC                : natural := 30;
        G_NBR_OF_ITERATIONS   : natural;
        G_FILEPATH_JSON       : string;
        G_INIT_FILEPATH_CIRC  : string;
        G_INIT_FILEPATH_HYPER : string
    );
end;

architecture bench of iterator_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    -- Generics
    constant G_DATA_WIDTH      : natural := G_WIDTH;
    constant G_DATA_FRAC_WIDTH : natural := G_FRAC;
    -- constant G_NBR_OF_ITERATIONS   : natural := C_NBR_OF_ITERATIONS;
    -- JSON Reads
    constant C_JSON_CONTENT : T_JSON := jsonLoad(G_FILEPATH_JSON);
    constant C_MODE         : string := jsonGetString(
    C_JSON_CONTENT,
    G_TYPE & "/0/mode"
    );
    constant C_SUBMODE : string := jsonGetString(
    C_JSON_CONTENT,
    G_TYPE & "/0/submode"
    );

    -- Ports
    signal clk           : std_logic := '0';
    signal i_mode        : t_mode;
    signal i_submode     : t_submode;
    signal i_data_x      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_y      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_z      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_data_tvalid : std_logic;
    signal o_data_x      : std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal o_data_y      : std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal o_data_z      : std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
    signal o_data_tvalid : std_logic;
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
    signal auto_data_tvalid       : std_logic;
    signal manual_data_x          : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal manual_data_y          : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal manual_data_z          : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal manual_data_tvalid     : std_logic;

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
    -- Read input file
    p_read_input_file : process
        file v_read_file  : text open read_mode is output_path(runner_cfg) & "/" & "input_data.txt";
        variable v_line   : line;
        variable v_data_x : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_y : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_z : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    begin
        tb_auto_done <= false;
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
            wait until o_data_tvalid = '1';
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
            if (o_data_tvalid = '1') then
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
    process (all)
    begin
        if (tb_auto_set = true) then
            i_data_x      <= auto_data_x;
            i_data_y      <= auto_data_y;
            i_data_z      <= auto_data_z;
            i_data_tvalid <= auto_data_tvalid;
        else -- MANUAL
            i_data_x      <= manual_data_x;
            i_data_y      <= manual_data_y;
            i_data_z      <= manual_data_z;
            i_data_tvalid <= manual_data_tvalid;
        end if;
    end process;
    -- ===================================================================
    main : process
        -------------------------------------------------
        procedure check_cordic (
            reference : real;
            actual    : real
        ) is
            variable v_actual_relative : real;
        begin
            v_actual_relative := actual / (reference + (1.0e-12));
            if (reference /= 0.0) then
                check_equal(
                v_actual_relative,
                1.0,
                "Mismatch! Reference=" &
                real'image(reference) &
                " vs Actual=" &
                real'image(actual) &
                " <-> %diff=" &
                real'image(v_actual_relative),
                max_diff => 0.001
                );
            end if;
            report "Pass!";
        end procedure;
        -------------------------------------------------
        variable v_data_x      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_y      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_data_z      : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_rad_float   : real    := 0.0;
        variable v_rad_fixed   : integer := 0;
        variable v_reference_x : real;
        variable v_reference_y : real;
        variable v_reference_z : real;
        -------------------------------------------------
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
            tb_auto_set <= true;
            i_mode      <= f_json_mode(C_MODE);
            i_submode   <= f_json_submode(C_SUBMODE);
            wait until tb_auto_done = true;
        end if;
        test_runner_cleanup(runner);
    end process main;
    -- ===================================================================
    -- Update debugs
    tb_input_data_x_float  <= real(to_integer(signed(i_data_x))) / (2.0 ** G_DATA_FRAC_WIDTH);
    tb_input_data_y_float  <= real(to_integer(signed(i_data_y))) / (2.0 ** G_DATA_FRAC_WIDTH);
    tb_input_data_z_float  <= real(to_integer(signed(i_data_z))) / (2.0 ** G_DATA_FRAC_WIDTH);
    tb_output_data_x_float <= real(to_integer(signed(o_data_x))) / (2.0 ** G_DATA_FRAC_WIDTH);
    tb_output_data_y_float <= real(to_integer(signed(o_data_y))) / (2.0 ** G_DATA_FRAC_WIDTH);
    tb_output_data_z_float <= real(to_integer(signed(o_data_z))) / (2.0 ** G_DATA_FRAC_WIDTH);
    -- ===================================================================
end;