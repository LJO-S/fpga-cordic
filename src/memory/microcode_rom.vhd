library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
use work.cordic_microcode_pkg.all;
-- 
entity microcode_rom is
    port (
        clk     : in std_logic;
        i_raddr : in std_logic_vector(integer(ceil(log2(real(C_MICROCODE_ROM_SIZE)))) - 1 downto 0);
        o_rdata : out t_step
    );
end entity microcode_rom;

architecture rtl of microcode_rom is
    signal r_microcode_memory : t_microcode_step_array(0 to C_MICROCODE_ROM_SIZE - 1) := C_MICROCODE_ROM;
begin
    -- ==================================================================
    process (clk)
    begin
        if rising_edge(clk) then
            o_rdata <= r_microcode_memory(to_integer(unsigned(i_raddr)));
        end if;
    end process;
    -- ==================================================================
end architecture;