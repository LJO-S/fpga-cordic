library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity microcode_rom_wrapper is
    generic (
        G_NBR_OF_FUNCTIONS : natural
    );
    port (
        clk : in std_logic;
        -- Input
        i_tvalid : in std_logic;
        i_tdata  : in std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        -- Output
        o_tdata  : out t_microcode;
        o_tvalid : out std_logic
    );
end entity microcode_rom_wrapper;

architecture rtl of microcode_rom_wrapper is

begin
    -- ===================================================================
    -- 1 cc read latency
    p_pipeline : process (clk)
    begin
        if rising_edge(clk) then
            o_tvalid <= i_tvalid;
        end if;
    end process p_pipeline;
    -- ===================================================================
    microcode_rom_inst : entity work.microcode_rom
        generic map(
            G_NBR_OF_FUNCTIONS => G_NBR_OF_FUNCTIONS
        )
        port map
        (
            clk       => clk,
            i_rd_addr => i_tdata,
            o_data    => o_data
        );
    -- ===================================================================
end architecture;