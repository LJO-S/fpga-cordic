library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity microcode_rom is
    generic (
        G_NBR_OF_FUNCTIONS : natural := 20
    );
    port (
        clk     : in std_logic;
        i_raddr : in std_logic_vector(integer(ceil(log2(real(G_NBR_OF_FUNCTIONS)))) - 1 downto 0);
        o_rdata : out t_microcode
    );
end entity microcode_rom;

architecture rtl of microcode_rom is
    signal mem_microcodes : t_microcode_registry; -- TODO defined in separate pkg
begin
    -- TODO implement record structure
    process (clk)
    begin
        if rising_edge(clk) then
            o_rdata <= mem_microcodes(to_integer(unsigned(i_raddr)));
        end if;
    end process;
end architecture;