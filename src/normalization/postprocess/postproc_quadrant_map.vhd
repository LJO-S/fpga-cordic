library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use std.textio.all;
-- 
use work.cordic_pkg.all;
-- 
entity postproc_quadrant_map is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_PI_FILEPATH       : string  := "../../data/pi_" & integer'image(G_DATA_WIDTH_DENORM) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt"
    );
    port (
        clk : in std_logic;
        -- Input 
        i_x        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_quadrant : in std_logic_vector(1 downto 0);
        i_valid    : in std_logic;
        -- Output
        o_x     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_z     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_valid : out std_logic
    );
end entity postproc_quadrant_map;

architecture rtl of postproc_quadrant_map is
    ----------------
    -- Types
    ----------------
    type t_pi_array is array (0 to 3) of std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);

    ----------------
    -- Functions
    ----------------
    function f_load_file_to_memory (
        file_path : string
    ) return t_pi_array is
        file v_file      : text;
        variable v_line  : line;
        variable v_slv   : std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        variable v_idx   : integer    := 0;
        variable v_array : t_pi_array := (others => (others => '0'));
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
    -- Constants
    ----------------
    constant C_MATH_PI_ARRAY          : t_pi_array                               := f_load_file_to_memory(G_PI_FILEPATH);
    constant C_MATH_2_PI_SIGNED       : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := signed(C_MATH_PI_ARRAY(0));
    constant C_MATH_3_PI_DIV_2_SIGNED : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := signed(C_MATH_PI_ARRAY(1));
    constant C_MATH_PI_SIGNED         : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := signed(C_MATH_PI_ARRAY(2));
    constant C_MATH_PI_DIV_2_SIGNED   : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := signed(C_MATH_PI_ARRAY(3));

    ----------------
    -- Signals
    ----------------
    signal r_x     : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_y     : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_z     : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_valid : std_logic                                := '0';
begin
    -- ===================================================================
    -- Combinatorial
    o_x     <= std_logic_vector(r_x);
    o_y     <= std_logic_vector(r_y);
    o_z     <= std_logic_vector(r_z);
    o_valid <= r_valid;
    -- ===================================================================
    p_quadrant_demap : process (clk)
    begin
        if rising_edge(clk) then
            r_valid <= i_valid;
            if (i_quadrant = "00") then
                r_x <= signed(i_x);
                r_y <= signed(i_y);
                r_z <= signed(i_z);
            elsif (i_quadrant = "01") then
                r_x <= - signed(i_x);
                r_y <= signed(i_y);
                r_z <= C_MATH_PI_SIGNED - signed(i_z);
            elsif (i_quadrant = "10") then
                r_x <= - signed(i_x);
                r_y <= - signed(i_y);
                r_z <= C_MATH_PI_SIGNED + signed(i_z);
            else
                -- 11
                r_x <= signed(i_x);
                r_y <= - signed(i_y);
                r_z <= C_MATH_2_PI_SIGNED - signed(i_z);
            end if;
        end if;
    end process p_quadrant_demap;
    -- ===================================================================
end architecture;