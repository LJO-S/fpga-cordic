library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity cordic is
    generic (
        G_DATA_WIDTH       : natural := 32;
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
    type t_cordic_state is (IDLE, FETCH_MICROCODE, CALCULATE);
    type t_calculation_state is (IDLE, PRE_PROCESS, ITERATE, POST_PROCESS, DONE);
    ----------------
    -- Functions
    ----------------
    ----------------
    -- Signals
    ----------------
    signal s_cordic_state      : t_cordic_state;
    signal s_calc_state        : t_calculation_state;
    signal w_config_tready_out : std_logic;
    signal w_data_tready_out   : std_logic;
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
    w_config_tready_out <= '1' when s_cordic_state = IDLE else
        '0';
    w_data_tready_out <= '1' when s_cordic_state = IDLE else
        '0';
    -- ===================================================================
    process (clk)
    begin
        if rising_edge(clk) then
            case s_cordic_state is
                    ---------------------------------------------
                when IDLE =>
                    ---------------------------------------------
                when PRE_PROCESS =>
                    ---------------------------------------------
                when ITERATE =>
                    ---------------------------------------------
                when POST_PROCESS =>
                    ---------------------------------------------
                when DONE =>
                    ---------------------------------------------
                when others =>
                    ---------------------------------------------
            end case;
        end if;
    end process;
    -- ===================================================================
    process (clk)
    begin
        if rising_edge(clk) then

            case s_cordic_state is
                    ---------------------------------------------
                when IDLE =>
                    if (i_config_tvalid = '1') and (w_config_tready_out = '1') then
                        s_cordic_state <= FETCH_MICROCODE;
                    elsif (i_data_tvalid = '1') and (w_data_tready_out = '1') then
                        s_cordic_state <= CALCULATE;
                    end if;
                    ---------------------------------------------
                when FETCH_MICROCODE =>
                    s_cordic_state <= IDLE;
                    ---------------------------------------------
                when CALCULATE =>
                    if (s_calc_state = DONE) then
                        s_cordic_state <= IDLE;
                    end if;
                    ---------------------------------------------
                when others =>
                    s_cordic_state <= IDLE;
                    ---------------------------------------------
            end case;
        end if;
    end process;
    -- ===================================================================
    p_parse_microcode : process (clk)
    begin
        if rising_edge(clk) then
            if (i_config_tvalid = '1') and (w_config_tready_out = '1') then
            end if;
        end if;
    end process p_parse_microcode;
    -- ===================================================================
end architecture;