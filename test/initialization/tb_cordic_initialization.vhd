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

entity cordic_initialization_tb is
    generic (
        runner_cfg : string
    );
end;

architecture bench of cordic_initialization_tb is
    -- Clock period
    constant clk_period : time := 5 ns;
    constant C_TIMEOUT  : time := 100 * clk_period;

    -- Generics
    constant G_DATA_WIDTH : natural := 31;
    constant G_FRAC_WIDTH : natural := 29;
    -- Ports
    signal clk      : std_logic := '0';
    signal i_x_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_x_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_x_type : t_initialization_type;
    signal i_y_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_y_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_y_type : t_initialization_type;
    signal i_z_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_z_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal i_z_type : t_initialization_type;
    signal i_valid  : std_logic;
    signal o_ready  : std_logic;
    signal o_x_data : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_y_data : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_z_data : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    signal o_valid  : std_logic;
    signal i_ready  : std_logic := '1';
    -- Testbench
    signal tb_input_data_x_float  : real    := 0.0;
    signal tb_input_data_y_float  : real    := 0.0;
    signal tb_input_data_z_float  : real    := 0.0;
    signal tb_output_data_x_float : real    := 0.0;
    signal tb_output_data_y_float : real    := 0.0;
    signal tb_output_data_z_float : real    := 0.0;
    signal tb_output_data_n_int   : integer := 0;

    -- Procedure
    procedure wait_clock (clk_ticks : integer) is
    begin
        for i in 0 to clk_ticks - 1 loop
            wait until rising_edge(clk);
        end loop;
    end procedure;

    procedure proc_check (
        signal i_valid    : inout std_logic;
        signal init_type  : in t_initialization_type;
        signal out_actual : in real
    ) is
        variable v_expect : real := 0.0;
    begin
        i_valid <= '1';
        wait_clock(1);
        i_valid <= '0';
        if (o_valid = '0') then
            wait until o_valid = '1' for C_TIMEOUT;
        end if;
        wait for 1 ps;
        check(
        o_valid = '1',
        "No valid signal!"
        );
        case init_type is
            when PROC_GAIN =>
                v_expect := 0.60725;
            when PROC_GAIN_INV =>
                v_expect := 1.0/0.60725;
            when PROC_GAIN_HYP =>
                v_expect := 0.82816;
            when PROC_GAIN_HYP_INV =>
                v_expect := 1.0/0.82816;
            when INPUT_X =>
                v_expect := real(to_integer(signed(i_x_in))) / (2.0 ** G_FRAC_WIDTH);
            when INPUT_Y =>
                v_expect := real(to_integer(signed(i_y_in))) / (2.0 ** G_FRAC_WIDTH);
            when INPUT_Z =>
                v_expect := real(to_integer(signed(i_z_in))) / (2.0 ** G_FRAC_WIDTH);
            when OUTPUT_X =>
                v_expect := real(to_integer(signed(i_x_prev))) / (2.0 ** G_FRAC_WIDTH);
            when OUTPUT_Y =>
                v_expect := real(to_integer(signed(i_y_prev))) / (2.0 ** G_FRAC_WIDTH);
            when OUTPUT_Z =>
                v_expect := real(to_integer(signed(i_z_prev))) / (2.0 ** G_FRAC_WIDTH);
            when others =>
                v_expect := 0.0;
        end case;
        check_equal(
        out_actual,
        v_expect,
        "Mismatch! Expected=" & real'image(v_expect) &
        " vs Actual=" & real'image(out_actual),
        max_diff => 0.0000001
        );

    end procedure;
begin
    -- ===================================================================
    clk <= not clk after clk_period/2;
    -- ===================================================================
    cordic_initialization_inst : entity work.cordic_initialization
        generic map(
            G_DATA_WIDTH => G_DATA_WIDTH,
            G_FRAC_WIDTH => G_FRAC_WIDTH
        )
        port map
        (
            clk => clk,
            -- X
            i_x_in   => i_x_in,
            i_x_prev => i_x_prev,
            i_x_type => i_x_type,
            -- Y
            i_y_in   => i_y_in,
            i_y_prev => i_y_prev,
            i_y_type => i_y_type,
            -- Z
            i_z_in   => i_z_in,
            i_z_prev => i_z_prev,
            i_z_type => i_z_type,
            -- Output + Handshake
            i_valid  => i_valid,
            o_ready  => o_ready,
            o_x_data => o_x_data,
            o_y_data => o_y_data,
            o_z_data => o_z_data,
            o_valid  => o_valid,
            i_ready  => i_ready
        );
    -- ===================================================================
    main : process
        -- ------------------------------
        variable v_seed1, v_seed2 : integer := 999;
        impure function f_rand_int (
            min_val : in natural;
            max_val : in natural
        ) return integer is
            variable v_real : real;
        begin
            UNIFORM(v_seed1, v_seed2, v_real);
            return integer(
            round(v_real * real(max_val - min_val + 1) + real(min_val) - 0.5)
            );
        end function;
        -- ------------------------------
        impure function rand_slv(len : integer) return std_logic_vector is
            variable r                   : real;
            variable slv                 : std_logic_vector(len - 1 downto 0);
        begin
            for i in slv'range loop
                uniform(v_seed1, v_seed2, r);
                slv(i) := '1' when r > 0.5 else
                '0';
            end loop;
            return slv;
        end function;
        -- ------------------------------
        variable v_x_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_x_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_y_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_y_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_z_in   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_z_prev : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        -- ------------------------------
    begin
        test_runner_setup(runner, runner_cfg);
        if run("auto") then
            info("Hello world!");
            wait until clk = '1';
            -- Default
            v_x_in   := rand_slv(G_DATA_WIDTH);
            v_x_prev := rand_slv(G_DATA_WIDTH);
            v_y_in   := rand_slv(G_DATA_WIDTH);
            v_y_prev := rand_slv(G_DATA_WIDTH);
            v_z_in   := rand_slv(G_DATA_WIDTH);
            v_z_prev := rand_slv(G_DATA_WIDTH);
            i_x_in   <= v_x_in;
            i_y_in   <= v_y_in;
            i_z_in   <= v_z_in;
            i_x_prev <= v_x_prev;
            i_y_prev <= v_y_prev;
            i_z_prev <= v_z_prev;
            ---------------------
            -- Test all configs
            ---------------------
            -- Input
            i_x_type <= INPUT_X;
            i_y_type <= INPUT_Y;
            i_z_type <= INPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_X;
            i_y_type <= INPUT_X;
            i_z_type <= INPUT_X;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_Y;
            i_y_type <= INPUT_Z;
            i_z_type <= INPUT_X;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            -- Prev
            i_x_type <= OUTPUT_X;
            i_y_type <= OUTPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_X;
            i_y_type <= OUTPUT_X;
            i_z_type <= OUTPUT_X;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_Z;
            i_y_type <= OUTPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_Z;
            i_y_type <= OUTPUT_X;
            i_z_type <= OUTPUT_Y;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            -- PROC GAIN
            i_x_type <= PROC_GAIN;
            i_y_type <= INPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_X;
            i_y_type <= PROC_GAIN;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_X;
            i_y_type <= INPUT_Y;
            i_z_type <= PROC_GAIN;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= PROC_GAIN;
            i_y_type <= PROC_GAIN;
            i_z_type <= PROC_GAIN;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            -- PROC GAIN INVERSE
            i_x_type <= PROC_GAIN_INV;
            i_y_type <= INPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_Z;
            i_y_type <= PROC_GAIN_INV;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_Z;
            i_y_type <= INPUT_Y;
            i_z_type <= PROC_GAIN_INV;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= PROC_GAIN_INV;
            i_y_type <= PROC_GAIN_INV;
            i_z_type <= PROC_GAIN_INV;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            -- PROC GAIN HYP
            i_x_type <= PROC_GAIN_HYP;
            i_y_type <= INPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_Z;
            i_y_type <= PROC_GAIN_HYP;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_Z;
            i_y_type <= INPUT_Y;
            i_z_type <= PROC_GAIN_HYP;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= PROC_GAIN_HYP;
            i_y_type <= PROC_GAIN_HYP;
            i_z_type <= PROC_GAIN_HYP;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            -- PROC GAIN INV HYP
            i_x_type <= PROC_GAIN_HYP_INV;
            i_y_type <= INPUT_Y;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= OUTPUT_Z;
            i_y_type <= PROC_GAIN_HYP_INV;
            i_z_type <= OUTPUT_Z;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= INPUT_Z;
            i_y_type <= INPUT_Y;
            i_z_type <= PROC_GAIN_HYP_INV;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
            i_x_type <= PROC_GAIN_HYP_INV;
            i_y_type <= PROC_GAIN_HYP_INV;
            i_z_type <= PROC_GAIN_HYP_INV;
            proc_check(i_valid, i_x_type, tb_output_data_x_float);
            proc_check(i_valid, i_y_type, tb_output_data_y_float);
            proc_check(i_valid, i_z_type, tb_output_data_z_float);
        end if;
        test_runner_cleanup(runner);
    end process main;
    -- ===================================================================
    -- Update debugs
    -- tb_input_data_x_float  <= real(to_integer(signed(i_x))) / (2.0 ** G_DATA_WIDTH_FRAC);
    -- tb_input_data_y_float  <= real(to_integer(signed(i_y))) / (2.0 ** G_DATA_WIDTH_FRAC);
    -- tb_input_data_z_float  <= real(to_integer(signed(i_z))) / (2.0 ** G_DATA_WIDTH_FRAC);
    tb_output_data_x_float <= real(to_integer(signed(o_x_data))) / (2.0 ** G_FRAC_WIDTH);
    tb_output_data_y_float <= real(to_integer(signed(o_y_data))) / (2.0 ** G_FRAC_WIDTH);
    tb_output_data_z_float <= real(to_integer(signed(o_z_data))) / (2.0 ** G_FRAC_WIDTH);
    -- ===================================================================
end;