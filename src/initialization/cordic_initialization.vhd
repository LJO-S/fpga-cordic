library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity cordic_initialization is
    generic (
        G_DATA_WIDTH : natural := 32;
        G_FRAC_WIDTH : natural := 30
    );
    port (
        clk : in std_logic;
        -- X
        i_x_in   : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_x_prev : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_x_type : in t_initialization_type;
        -- Y
        i_y_in   : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_y_prev : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_y_type : in t_initialization_type;
        -- Z
        i_z_in   : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_z_prev : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        i_z_type : in t_initialization_type;
        -- Input Handshake
        i_valid : in std_logic;
        o_ready : out std_logic;
        -- Output
        o_x_data : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_y_data : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_z_data : out std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        o_valid  : out std_logic;
        i_ready  : in std_logic
    );
end entity cordic_initialization;

architecture rtl of cordic_initialization is
    ----------------
    -- Types
    ----------------

    ----------------
    -- Constants
    ----------------
    constant C_PROC_GAIN         : signed(G_DATA_WIDTH - 1 downto 0) := f_real_to_signed(0.60725, G_DATA_WIDTH, G_FRAC_WIDTH);
    constant C_PROC_GAIN_INV     : signed(G_DATA_WIDTH - 1 downto 0) := f_real_to_signed(1.0/0.60725, G_DATA_WIDTH, G_FRAC_WIDTH);
    constant C_PROC_GAIN_HYP     : signed(G_DATA_WIDTH - 1 downto 0) := f_real_to_signed(0.82816, G_DATA_WIDTH, G_FRAC_WIDTH);
    constant C_PROC_GAIN_HYP_INV : signed(G_DATA_WIDTH - 1 downto 0) := f_real_to_signed(1.0/0.82816, G_DATA_WIDTH, G_FRAC_WIDTH);
    ----------------
    -- Functions
    ----------------
    function f_select_init (
        init : t_initialization_type
    ) return signed is
    begin
        case init is
            when PROC_GAIN =>
                return C_PROC_GAIN;
            when PROC_GAIN_INV =>
                return C_PROC_GAIN_INV;
            when PROC_GAIN_HYP =>
                return C_PROC_GAIN_HYP;
            when PROC_GAIN_HYP_INV =>
                return C_PROC_GAIN_HYP_INV;
            when INPUT_X =>
                return signed(i_x_in);
            when INPUT_Y =>
                return signed(i_y_in);
            when INPUT_Z =>
                return signed(i_z_in);
            when OUTPUT_X =>
                return signed(i_x_prev);
            when OUTPUT_Y =>
                return signed(i_y_prev);
            when OUTPUT_Z =>
                return signed(i_z_prev);
            when others =>
                return (G_DATA_WIDTH - 1 downto 0 => '0');
        end case;
    end function;
    ----------------
    -- Signals
    ----------------
begin
    -- ===================================================================
    p_init_values : process (clk)
    begin
        if rising_edge(clk) then
            o_ready  <= '1'; -- no back-pressure needed
            o_valid  <= '0';
            o_x_data <= (others => '0');
            o_y_data <= (others => '0');
            o_z_data <= (others => '0');
            if (i_valid = '1') and (i_ready = '1') then
                o_x_data <= std_logic_vector(f_select_init(i_x_type));
                o_y_data <= std_logic_vector(f_select_init(i_y_type));
                o_z_data <= std_logic_vector(f_select_init(i_z_type));
                o_valid  <= '1';
            end if;
        end if;
    end process p_init_values;
    -- ===================================================================
end architecture;