library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use std.textio.all;
-- 
use work.cordic_pkg.all;
use work.tb_pkg.all;
--
library vunit_lib;
context vunit_lib.vunit_context;

entity cordic_preprocess_tb is
    generic (
        runner_cfg          : string;
        G_DATA_WIDTH_DENORM : natural;
        G_DATA_WIDTH_NORM   : natural;
        G_DATA_WIDTH_FRAC   : natural;
        G_SHIFT_WIDTH       : natural;
        G_RANGE_N_WIDTH     : natural;
        G_SHIFT_COMMON      : boolean;
        G_SHIFT_DOUBLE      : boolean;
        G_SHIFT_INPUTS      : integer;
        G_NORM_TYPE         : integer;
        G_PI_FILEPATH       : string := output_path(runner_cfg) & "/pi_" & integer'image(G_DATA_WIDTH_DENORM) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt"
    );
end;

architecture bench of cordic_preprocess_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    -- Generics
    -- Ports
    signal clk          : std_logic := '0';
    signal i_config     : t_normalization;
    signal i_x          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_y          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_z          : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
    signal i_valid      : std_logic;
    signal o_ready      : std_logic;
    signal o_x          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_y          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_z          : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
    signal o_bitshift_x : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal o_bitshift_y : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal o_bitshift_z : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
    signal o_quadrant   : std_logic_vector(1 downto 0);
    signal o_range_n    : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
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
    signal auto_data_tvalid       : std_logic;

    procedure wait_clock (clk_ticks : integer) is
    begin
        for i in 0 to clk_ticks - 1 loop
            wait until rising_edge(clk);
        end loop;
    end procedure;

    function f_int_to_slv (
        value : integer
    ) return std_logic_vector is
        variable v_val : integer;
        variable v_slv : std_logic_vector(2 downto 0);
    begin
        v_slv := "000";
        v_val := value / 100;
        if (v_val >= 1) then
            v_slv(2) := '1';
        end if;
        v_val := (value / 10) mod 10;
        if (v_val >= 1) then
            v_slv(1) := '1';
        end if;
        v_val := value mod 10;
        if (v_val >= 1) then
            v_slv(0) := '1';
        end if;

        return v_slv;
    end function;
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
    i_x            <= auto_data_x;
    i_y            <= auto_data_y;
    i_z            <= auto_data_z;
    i_valid        <= auto_data_tvalid;
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
                write(v_line, o_bitshift_x, right, o_bitshift_x'length + 4);
                write(v_line, o_bitshift_y, right, o_bitshift_y'length + 4);
                write(v_line, o_bitshift_z, right, o_bitshift_z'length + 4);
                write(v_line, o_quadrant, right, o_quadrant'length + 4);
                write(v_line, o_range_n, right, o_range_n'length + 4);
                -- Write to file
                writeline(v_write_file, v_line);
            end if;
        end if;
    end process p_write_output_file;
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
            i_ready      => '1',
            o_valid      => o_valid
        );
    -- ===================================================================
    p_config : process (all)
        variable v_norm_type : std_logic_vector(2 downto 0);
    begin
        v_norm_type := f_int_to_slv(G_NORM_TYPE);
        -- Bitshift
        i_config.norm_en           <= v_norm_type(0);
        i_config.norm_common       <= '0';
        i_config.norm_shift_double <= '0';
        i_config.norm_input        <= f_int_to_slv(G_SHIFT_INPUTS);
        if (G_SHIFT_COMMON = true) then
            i_config.norm_common <= '1';
        end if;
        if (G_SHIFT_DOUBLE = true) then
            i_config.norm_shift_double <= '1';
        end if;
        -- Range Reduce
        i_config.reduction_en          <= v_norm_type(1);
        i_config.reduction_reconstruct <= '0';
        -- Quadrant
        i_config.quadrant_en <= v_norm_type(2);
    end process p_config;

    main : process
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
            info("Hello world!");
            wait until clk = '1';
            tb_auto_set <= true;
            wait until tb_auto_done = true;
            wait_clock(100);
        end if;
        test_runner_cleanup(runner);
    end process main;
    -- ===================================================================
end;
