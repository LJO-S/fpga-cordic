library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use std.textio.all;
-- 
entity angle_rom is
    generic (
        G_DATA_WIDTH    : natural := 32;
        G_DATA_DEPTH    : natural := 32;
        G_INIT_FILEPATH : string
    );
    port (
        clk     : in std_logic;
        i_raddr : in std_logic_vector(integer(ceil(log2(real(G_DATA_DEPTH)))) - 1 downto 0);
        o_rdata : out std_logic_vector(G_DATA_WIDTH - 1 downto 0)
    );
end entity angle_rom;

architecture rtl of angle_rom is
    ----------------
    -- Constants
    ----------------
    ----------------
    -- Types
    ----------------
    type t_memory is array (0 to G_DATA_DEPTH) of std_logic_vector(G_DATA_WIDTH - 1 downto 0);
    ----------------
    -- Functions
    ----------------
    function f_load_file_to_memory (
        file_path : string
    ) return t_memory is
        file v_file      : text;
        variable v_line  : line;
        variable v_slv   : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
        variable v_idx   : integer  := 0;
        variable v_array : t_memory := (others => (others => '0'));
    begin
        FILE_OPEN(v_file, file_path, READ_MODE);

        while not ENDFILE(v_file) loop
            READLINE(v_file, v_line);
            READ(v_line, v_slv);
            report "v_slv: " & to_hstring(v_slv);
            v_array(v_idx) := v_slv;
            v_idx          := v_idx + 1;
        end loop;

        FILE_CLOSE(v_file);

        return v_array;
    end function;
    ----------------
    -- Functions
    ----------------
    signal mem_angle : t_memory := f_load_file_to_memory(G_INIT_FILEPATH);
begin
    -- ======================================================
    p_rom : process (clk)
    begin
        if rising_edge(clk) then
            o_rdata <= mem_angle(to_integer(unsigned(i_raddr)));
        end if;
    end process p_rom;
    -- ======================================================
end architecture;