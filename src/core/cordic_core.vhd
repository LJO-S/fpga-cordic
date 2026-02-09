library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity cordic_core is
    generic (
        G_NBR_OF_FUNCTIONS  : natural := 20;
        G_NBR_OF_ITERATIONS : natural := 40;
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30;
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
        o_microcode_data  : out std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        o_microcode_valid : out std_logic;
        i_microcode_data  : in t_microcode;
        i_microcode_valid : in std_logic;
        o_mode            : out t_mode;
        o_submode         : out t_submode;
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
        -- TODO what bit width..
        o_init_x_input : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_x_prev  : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_x_type  : out t_initialization_type;
        o_init_y_input : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_y_prev  : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_y_type  : out t_initialization_type;
        o_init_z_input : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_z_prev  : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_init_z_type  : out t_initialization_type;
        o_init_valid   : out std_logic;
        i_init_x       : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_init_y       : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        i_init_z       : in std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
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
        i_postproc_ready : in std_logic;
        o_postproc_x     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_postproc_y     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_postproc_z     : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_postproc_meta  : out t_normalization_meta;
        o_postproc_valid : out std_logic;
        i_postproc_x     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_y     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_z     : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_postproc_valid : in std_logic;
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
    ----------------
    -- Types
    ----------------
    type t_cordic_state is (IDLE, FETCH_MICROCODE, CALCULATE);
    type t_calculation_state is (IDLE, CHECK_STEP, INIT, PRE_PROCESS, WAIT_ITERATE_READY, ITERATE_START, ITERATE_BUSY, POST_PROCESS, DONE);
    ----------------
    -- Functions
    ----------------
    ----------------
    -- Signals
    ----------------
    signal s_config_state     : t_cordic_state;
    signal s_cordic_state     : t_calculation_state;
    signal w_config_ready_out : std_logic;
    signal w_data_ready_out   : std_logic;
    -- Idle
    signal r_input_x : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_input_y : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_input_z : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    -- Check step
    signal r_microcode : t_microcode;
    signal r_step_iter : unsigned(integer(ceil(log2(real(C_MAX_NBR_OF_STEPS)))) - 1 downto 0) := (others => '0');
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
    signal r_iterator_x_in      : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_iterator_y_in      : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_iterator_z_in      : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_iterator_valid_out : std_logic                                        := '0';
    -- Post-process
    signal r_postproc_x_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_postproc_y_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_postproc_z_in : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
begin
    -- TODO
    -- Structure:
    -- 1. In idle we can always fetch new microrecords
    -- 2. data_tvalid starts the FSM
    -- 3. First pre-process the input
    -- 4. Fetch normalizer meta data and send to iterator
    -- 5. Iterate...
    -- 6. Fetch data and send to post-process
    -- 7. Done! Back to 1.
    -- ===================================================================
    -- Combinatorial
    w_config_ready_out <= '1' when s_config_state = IDLE else
        '0';
    w_data_ready_out <= w_config_ready_out;
    ------------
    -- Init
    ------------
    o_init_valid   <= r_init_valid_out;
    o_init_x_type  <= r_microcode.step.init(0).source;
    o_init_z_type  <= r_microcode.step.init(1).source;
    o_init_y_type  <= r_microcode.step.init(2).source;
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
    o_preproc_config <= r_microcode.step.norm;
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
    -- ===================================================================
    p_cordic_fsm : process (clk)
    begin
        if rising_edge(clk) then
            --------------------
            -- Defaults
            --------------------
            r_init_valid_out     <= '0';
            r_preproc_valid_out  <= '0';
            r_iterator_valid_out <= '0';
            -- FSM
            case s_cordic_state is
                    ---------------------------------------------
                when IDLE =>
                    if (i_data_valid = '1') then
                        -- Zero step cntr
                        r_step_iter <= (others => '0');
                        -- Latch data
                        r_input_x      <= i_data_x;
                        r_input_y      <= i_data_y;
                        r_input_z      <= i_data_z;
                        s_cordic_state <= CHECK_STEP;
                    end if;
                    ---------------------------------------------
                when CHECK_STEP =>
                    if (r_step_iter > r_microcode.nbr_of_steps - 1) then
                        s_cordic_state <= DONE;
                    else
                        -- TODO perhaps here we should first wait new data from the microrecord
                        r_init_valid_out <= '1';
                        s_cordic_state   <= INIT;
                    end if;
                    ---------------------------------------------
                when INIT =>
                    -- Fetch offset for later
                    r_init_x_offset <= signed(r_microcode.step.init(0).offset);
                    r_init_y_offset <= signed(r_microcode.step.init(1).offset);
                    r_init_z_offset <= signed(r_microcode.step.init(2).offset);
                    -- Wait until initialization is done
                    if (i_init_valid = '1') then
                        r_init_x            <= i_init_x;
                        r_init_y            <= i_init_y;
                        r_init_z            <= i_init_z;
                        r_preproc_valid_out <= '1';

                        s_cordic_state <= PRE_PROCESS;
                    end if;
                    ---------------------------------------------
                when PRE_PROCESS =>
                    if (i_preproc_valid = '1') then
                        -- Add offset after pre-processing
                        -- TODO will this pose a problem?
                        r_preproc_x_in <= signed(i_preproc_x) + r_init_x_offset;
                        r_preproc_y_in <= signed(i_preproc_y) + r_init_y_offset;
                        r_preproc_z_in <= signed(i_preproc_z) + r_init_z_offset;
                        -- Latch meta data
                        r_preproc_bitshift_x <= i_bitshift_x;
                        r_preproc_bitshift_y <= i_bitshift_y;
                        r_preproc_bitshift_z <= i_bitshift_z;
                        r_preproc_quadrant   <= i_quadrant;
                        r_preproc_range_n    <= i_range_n;

                        s_cordic_state <= WAIT_ITERATE_READY;
                    end if;
                    ---------------------------------------------
                when ITERATE_START =>
                    if (i_iterator_ready = '1') then
                        r_iterator_valid_out <= '1';
                        s_cordic_state       <= ITERATE_START;
                    end if;
                    ---------------------------------------------
                when ITERATE_START =>
                    if (i_iterator_valid = '1') then
                        r_iterator_x_in <= i_iterator_x;
                        r_iterator_y_in <= i_iterator_y;
                        r_iterator_z_in <= i_iterator_z;
                        s_cordic_state  <= POST_PROCESS;
                    end if;
                    ---------------------------------------------
                when POST_PROCESS =>
                    r_postproc_x_in <= i_postproc_x;
                    r_postproc_y_in <= i_postproc_y;
                    r_postproc_z_in <= i_postproc_z;
                    if (i_postproc_valid = '1') then
                        r_step_iter    <= r_step_iter + 1;
                        s_cordic_state <= CHECK_STEP;
                    end if;
                    ---------------------------------------------
                when DONE =>
                    s_cordic_state <= IDLE;
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
            case s_config_state is
                    ---------------------------------------------
                when IDLE =>
                    if (i_config_valid = '1') and (w_config_ready_out = '1') then
                        s_config_state <= FETCH_MICROCODE;
                    elsif (i_data_valid = '1') and (w_data_ready_out = '1') then
                        s_config_state <= CALCULATE;
                    end if;
                    ---------------------------------------------
                when FETCH_MICROCODE =>
                    if (i_microcode_valid = '1') then
                        r_microcode    <= i_microcode_data;
                        s_config_state <= IDLE;
                    end if;
                    ---------------------------------------------
                when CALCULATE =>
                    if (s_cordic_state = DONE) then
                        s_config_state <= IDLE;
                    end if;
                    ---------------------------------------------
                when others =>
                    s_config_state <= IDLE;
                    ---------------------------------------------
            end case;
        end if;
    end process p_config_fsm;
    -- ===================================================================
end architecture;