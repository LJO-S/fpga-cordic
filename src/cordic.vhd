library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.cordic_pkg.all;

entity cordic is
    port (
        clk   : in std_logic;
        reset : in std_logic;

        i_config_tdata  : in std_logic_vector(2 downto 0);
        i_config_tvalid : in std_logic;

        o_tdata : out std_logic
    );
end entity cordic;

architecture rtl of cordic is
    -- TODO Not sure if these should be here
    signal r_mode    : t_mode    := LINEAR;
    signal r_submode : t_submode := VECTORING;
begin
    -- ===================================================================
    -- Control
    -- ===================================================================
    -- Microcode ROM
    -- ===================================================================
    -- Pre-Process
    -- ===================================================================
    -- Iterator
    -- ===================================================================
    -- Post-Process
    -- ===================================================================
    -- Others
    process (clk)
    begin
        if rising_edge(clk) then
            if (i_config_tvalid = '1') then
                r_mode    <= f_mode_translate(i_config_tdata(2 downto 1));
                r_submode <= f_submode_translate(i_config_tdata(0));
            end if;
        end if;
    end process;
    -- ===================================================================
    -- Combinatorial
    -- ===================================================================

end architecture;