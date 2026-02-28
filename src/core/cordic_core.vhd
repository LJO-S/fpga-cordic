library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
use work.cordic_microcode_pkg.all;
-- 
entity cordic_core is
    generic (
        G_NBR_OF_FUNCTIONS  : natural := 20;
        G_NBR_OF_ITERATIONS : natural := 40;
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_SHIFT_WIDTH       : natural := 5;
        G_RANGE_N_WIDTH     : natural := 10
    );
    port (
        clk : in std_logic;
        -----------------
        -- Config
        -----------------
        i_config_data  : in std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        i_config_valid : in std_logic;
        o_config_ready : out std_logic;
        -----------------
        -- Microcode ROM
        -----------------
        i_step_data  : in t_step;
        i_step_valid : in std_logic;
        o_step_re    : out std_logic;
        o_step_raddr : out std_logic_vector(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0);
        -----------------
        -- Step meta data
        -----------------
        o_mode     : out t_mode;
        o_submode  : out t_submode;
        o_norm_cfg : out t_normalization;
        -----------------
        -- Input data
        -----------------
        i_data_x     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_data_y     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_data_z     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_data_valid : in std_logic;
        o_data_ready : out std_logic;
        -----------------
        -- Init
        -----------------
        o_init_x_input : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_x_prev  : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_x_type  : out t_initialization_type;
        o_init_y_input : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_y_prev  : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_y_type  : out t_initialization_type;
        o_init_z_input : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_z_prev  : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_init_z_type  : out t_initialization_type;
        o_init_valid   : out std_logic;
        i_init_x       : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_init_y       : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_init_z       : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_init_valid   : in std_logic;
        -----------------
        -- Pre-Process
        -----------------
        i_preproc_ready  : in std_logic;
        o_preproc_config : out t_normalization;
        o_preproc_x      : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_preproc_y      : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_preproc_z      : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_preproc_valid  : out std_logic;
        i_preproc_x      : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_preproc_y      : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_preproc_z      : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_bitshift_x     : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        i_bitshift_y     : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        i_bitshift_z     : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0) := (others => '0');
        i_quadrant       : in std_logic_vector(1 downto 0);
        i_range_n        : in std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');
        i_preproc_valid  : in std_logic;
        -----------------
        -- Iterator 
        -----------------
        i_iterator_x     : in std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        i_iterator_y     : in std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        i_iterator_z     : in std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        i_iterator_valid : in std_logic;
        o_iterator_x     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_iterator_y     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_iterator_z     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_iterator_ready : in std_logic;
        o_iterator_valid : out std_logic;
        -----------------
        -- Post-Process
        -----------------
        i_postproc_ready      : in std_logic;
        o_postproc_x          : out std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        o_postproc_y          : out std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        o_postproc_z          : out std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
        o_postproc_bitshift_x : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_postproc_bitshift_y : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_postproc_bitshift_z : out std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        o_postproc_range_n    : out std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
        o_postproc_quadrant   : out std_logic_vector(1 downto 0);
        o_postproc_valid      : out std_logic;
        i_postproc_x          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_y          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_z          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_valid      : in std_logic;
        -----------------
        -- Output data
        -----------------
        o_data_x     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_data_y     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_data_z     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_data_valid : out std_logic
        -----------------
    );
end entity cordic_core;

architecture rtl of cordic_core is
    ----------------
    -- Constants
    ----------------
    signal r_function_registry : t_function_array := C_FUNCTION_ARRAY;
    signal r_offset_pool       : t_offset_pool    := C_OFFSET_POOL;
    ----------------
    -- Types
    ----------------
    type t_config_state is (IDLE, FETCH_MICROCODE, BUSY_CALCULATING);
    type t_cordic_state is (IDLE, FETCH_STEP, CHECK_STEP, INIT, PRE_PROCESS, ITERATE_READY, ITERATE_RUN, ITERATE_BUSY, POST_PROCESS);
    ----------------
    -- Functions
    ----------------
    ----------------
    -- Signals
    ----------------
    -- Status
    signal s_config_state     : t_config_state := IDLE;
    signal s_cordic_state     : t_cordic_state := IDLE;
    signal w_config_ready_out : std_logic;
    signal w_cordic_ready_out : std_logic;
    -- Config
    signal r_config_data : std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0) := (others => '0');
    -- Idle
    signal r_input_x : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_input_y : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_input_z : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    -- Check step
    signal r_step                 : t_step;
    signal r_step_re              : std_logic                                                              := '0';
    signal r_step_raddr           : unsigned(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0) := (others => '0');
    signal r_microcode_start_addr : unsigned(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0) := (others => '0');
    -- Init
    signal r_init_valid_out : std_logic                                          := '0';
    signal r_init_x         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_init_y         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_init_z         : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_init_x_offset  : signed(G_DATA_WIDTH_NORM - 1 downto 0)             := (others => '0');
    signal r_init_y_offset  : signed(G_DATA_WIDTH_NORM - 1 downto 0)             := (others => '0');
    signal r_init_z_offset  : signed(G_DATA_WIDTH_NORM - 1 downto 0)             := (others => '0');
    -- Pre-process
    signal r_preproc_valid_out  : std_logic                                      := '0';
    signal r_preproc_x_in       : signed(G_DATA_WIDTH_NORM - 1 downto 0)         := (others => '0');
    signal r_preproc_y_in       : signed(G_DATA_WIDTH_NORM - 1 downto 0)         := (others => '0');
    signal r_preproc_z_in       : signed(G_DATA_WIDTH_NORM - 1 downto 0)         := (others => '0');
    signal r_preproc_bitshift_x : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0)   := (others => '0');
    signal r_preproc_bitshift_y : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0)   := (others => '0');
    signal r_preproc_bitshift_z : std_logic_vector(G_SHIFT_WIDTH - 1 downto 0)   := (others => '0');
    signal r_preproc_quadrant   : std_logic_vector(1 downto 0)                   := (others => '0');
    signal r_preproc_range_n    : std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');
    -- Iterator
    -- signal r_iterator_x_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    -- signal r_iterator_y_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    -- signal r_iterator_z_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_iterator_x_in      : std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0) := (others => '0');
    signal r_iterator_y_in      : std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0) := (others => '0');
    signal r_iterator_z_in      : std_logic_vector(G_DATA_WIDTH_NORM + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0) := (others => '0');
    signal r_iterator_valid_out : std_logic                                                                                         := '0';
    -- Post-process
    signal r_postproc_valid_out : std_logic                                          := '0';
    signal r_postproc_x_in      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_postproc_y_in      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_postproc_z_in      : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    -- Out
    signal r_valid_out : std_logic := '0';
begin
    -- ===================================================================
    -- Combinatorial
    w_config_ready_out <= '1' when (s_config_state = IDLE) else
        '0';
    w_cordic_ready_out <= '1' when (s_cordic_state = IDLE) else
        '0';
    -----------------
    -- Meta data
    -----------------
    o_mode     <= r_step.mode;
    o_submode  <= r_step.submode;
    o_norm_cfg <= r_step.norm;
    -----------------
    -- Microcode ROM
    -----------------
    o_step_re    <= r_step_re;
    o_step_raddr <= std_logic_vector(r_step_raddr);
    ------------
    -- Init
    ------------
    o_init_valid   <= r_init_valid_out;
    o_init_x_type  <= r_step.init(0).source;
    o_init_y_type  <= r_step.init(1).source;
    o_init_z_type  <= r_step.init(2).source;
    o_init_x_input <= r_input_x;
    o_init_y_input <= r_input_y;
    o_init_z_input <= r_input_z;
    o_init_x_prev  <= r_postproc_x_in;
    o_init_y_prev  <= r_postproc_y_in;
    o_init_z_prev  <= r_postproc_z_in;
    ------------
    -- Preprocess
    ------------
    o_preproc_valid  <= r_preproc_valid_out;
    o_preproc_x      <= r_init_x;
    o_preproc_y      <= r_init_y;
    o_preproc_z      <= r_init_z;
    o_preproc_config <= r_step.norm;
    ------------
    -- Iterator
    ------------
    o_iterator_valid <= r_iterator_valid_out;
    o_iterator_x     <= std_logic_vector(r_preproc_x_in);
    o_iterator_y     <= std_logic_vector(r_preproc_y_in);
    o_iterator_z     <= std_logic_vector(r_preproc_z_in);
    ------------
    -- Postprocess
    ------------
    o_postproc_valid      <= r_postproc_valid_out;
    o_postproc_x          <= r_iterator_x_in;
    o_postproc_y          <= r_iterator_y_in;
    o_postproc_z          <= r_iterator_z_in;
    o_postproc_bitshift_x <= r_preproc_bitshift_x;
    o_postproc_bitshift_y <= r_preproc_bitshift_y;
    o_postproc_bitshift_z <= r_preproc_bitshift_z;
    o_postproc_range_n    <= r_preproc_range_n;
    o_postproc_quadrant   <= r_preproc_quadrant;
    ------------
    -- Output
    ------------
    o_config_ready <= w_config_ready_out;
    o_data_ready   <= w_cordic_ready_out;
    o_data_valid   <= r_valid_out;
    o_data_x       <= r_postproc_x_in;
    o_data_y       <= r_postproc_y_in;
    o_data_z       <= r_postproc_z_in;
    -- ===================================================================
    p_cordic_fsm : process (clk)
    begin
        if rising_edge(clk) then
            --------------------
            -- Defaults
            --------------------
            r_step_re            <= '0';
            r_init_valid_out     <= '0';
            r_preproc_valid_out  <= '0';
            r_iterator_valid_out <= '0';
            r_postproc_valid_out <= '0';
            r_valid_out          <= '0';
            -- FSM
            case s_cordic_state is
                    ---------------------------------------------
                when IDLE =>
                    -- Latch data
                    r_input_x <= i_data_x;
                    r_input_y <= i_data_y;
                    r_input_z <= i_data_z;
                    -- Set step start address
                    r_step_raddr <= r_microcode_start_addr;
                    if (i_data_valid = '1') and (w_config_ready_out = '1') and (i_config_valid /= '1') then
                        -- Zero step cntr
                        r_step_re      <= '1';
                        s_cordic_state <= FETCH_STEP;
                    end if;
                    ---------------------------------------------
                when FETCH_STEP =>
                    r_step <= i_step_data;
                    if (i_step_valid = '1') then
                        r_init_valid_out <= '1';
                        s_cordic_state   <= INIT;
                    end if;
                    ---------------------------------------------
                when INIT =>
                    r_preproc_valid_out <= r_preproc_valid_out;
                    -- Wait until initialization is done
                    if (i_init_valid = '1') then
                        r_init_x            <= i_init_x;
                        r_init_y            <= i_init_y;
                        r_init_z            <= i_init_z;
                        r_preproc_valid_out <= '1';
                    end if;
                    if (r_preproc_valid_out = '1') and (i_preproc_ready = '1') then
                        r_preproc_valid_out <= '0';
                        s_cordic_state      <= PRE_PROCESS;
                    end if;
                    ---------------------------------------------
                when PRE_PROCESS =>
                    -- Add offset after pre-processing
                    r_preproc_x_in <= signed(i_preproc_x) + r_init_x_offset;
                    r_preproc_y_in <= signed(i_preproc_y) + r_init_y_offset;
                    r_preproc_z_in <= signed(i_preproc_z) + r_init_z_offset;
                    -- Latch meta data
                    r_preproc_bitshift_x <= i_bitshift_x;
                    r_preproc_bitshift_y <= i_bitshift_y;
                    r_preproc_bitshift_z <= i_bitshift_z;
                    r_preproc_quadrant   <= i_quadrant;
                    r_preproc_range_n    <= i_range_n;
                    if (i_preproc_valid = '1') then
                        s_cordic_state <= ITERATE_READY;
                    end if;
                    ---------------------------------------------
                when ITERATE_READY =>
                    if (i_iterator_ready = '1') then
                        r_iterator_valid_out <= '1';
                        s_cordic_state       <= ITERATE_RUN;
                    end if;
                    ---------------------------------------------
                when ITERATE_RUN =>
                    r_postproc_valid_out <= r_postproc_valid_out;
                    if (i_iterator_valid = '1') then
                        -- r_iterator_x_in      <= std_logic_vector(resize(signed(i_iterator_x), r_iterator_x_in'length));
                        -- r_iterator_y_in      <= std_logic_vector(resize(signed(i_iterator_y), r_iterator_y_in'length));
                        -- r_iterator_z_in      <= std_logic_vector(resize(signed(i_iterator_z), r_iterator_z_in'length));
                        r_iterator_x_in      <= i_iterator_x(r_iterator_x_in'range);
                        r_iterator_y_in      <= i_iterator_y(r_iterator_y_in'range);
                        r_iterator_z_in      <= i_iterator_z(r_iterator_z_in'range);
                        r_postproc_valid_out <= '1';
                    end if;
                    if (r_postproc_valid_out = '1') and (i_postproc_ready = '1') then
                        r_postproc_valid_out <= '0';
                        s_cordic_state       <= POST_PROCESS;
                    end if;
                    ---------------------------------------------
                when POST_PROCESS =>
                    r_postproc_x_in <= i_postproc_x;
                    r_postproc_y_in <= i_postproc_y;
                    r_postproc_z_in <= i_postproc_z;
                    if (i_postproc_valid = '1') then
                        if (r_step.last = '1') then
                            r_valid_out    <= '1';
                            s_cordic_state <= IDLE;
                        else
                            r_step_re      <= '1';
                            r_step_raddr   <= r_step_raddr + 1;
                            s_cordic_state <= FETCH_STEP;
                        end if;
                    end if;
                    ---------------------------------------------
                when others =>
                    s_cordic_state <= IDLE;
                    ---------------------------------------------
            end case;
        end if;
    end process p_cordic_fsm;
    -- ===================================================================
    p_config_fsm : process (clk)
    begin
        if rising_edge(clk) then
            -- FSM
            case s_config_state is
                    ---------------------------------------------
                when IDLE =>
                    if (i_config_valid = '1') and (w_cordic_ready_out = '1') and (i_data_valid /= '1') then
                        r_config_data  <= i_config_data;
                        s_config_state <= FETCH_MICROCODE;
                    end if;
                    ---------------------------------------------
                when FETCH_MICROCODE =>
                    -- Fetch start address from function registry
                    r_microcode_start_addr <= r_function_registry(to_integer(unsigned(r_config_data)));
                    s_config_state         <= IDLE;
                    ---------------------------------------------
                when others =>
                    s_config_state <= IDLE;
                    ---------------------------------------------
            end case;
        end if;
    end process p_config_fsm;
    -- ===================================================================
    -- Offset Pool
    p_offset_pool : process (clk)
    begin
        if rising_edge(clk) then
            r_init_x_offset <= r_offset_pool(to_integer(r_step.init(0).const_id));
            r_init_y_offset <= r_offset_pool(to_integer(r_step.init(1).const_id));
            r_init_z_offset <= r_offset_pool(to_integer(r_step.init(2).const_id));
        end if;
    end process p_offset_pool;
    -- ===================================================================
end architecture;