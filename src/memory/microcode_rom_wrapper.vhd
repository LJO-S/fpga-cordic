library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
use work.cordic_microcode_pkg.all;
-- 
entity microcode_rom_wrapper is
    port (
        clk : in std_logic;
        -- Input
        i_re    : in std_logic;
        i_raddr : in std_logic_vector(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0);
        -- Output
        o_data  : out t_step;
        o_valid : out std_logic
    );
end entity microcode_rom_wrapper;

architecture rtl of microcode_rom_wrapper is

begin
    -- ===================================================================
    -- 1 cc read latency
    p_pipeline : process (clk)
    begin
        if rising_edge(clk) then
            o_valid <= i_re;
        end if;
    end process p_pipeline;
    -- ===================================================================
    microcode_rom_inst : entity work.microcode_rom
        port map
        (
            clk     => clk,
            i_raddr => i_raddr,
            o_rdata => o_data
        );
    -- ===================================================================
end architecture;