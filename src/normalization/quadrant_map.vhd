library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use std.textio.all;
-- 
use work.cordic_pkg.all;
-- 
entity quadrant_map is
    generic (
        G_DATA_WIDTH_DENORM : natural := 32;
        G_DATA_WIDTH_NORM   : natural := 32;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_PI_FILEPATH       : string  := "../../data/pi_" & integer'image(G_DATA_WIDTH_DENORM) & "b" & integer'image(G_DATA_WIDTH_FRAC) & "f.txt"
    );
    port (
        clk        : in std_logic;
        i_x        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z        : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0); -- Assume Z >= 0
        i_valid    : in std_logic;
        o_x        : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_y        : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_z        : out std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0);
        o_quadrant : out std_logic_vector(1 downto 0);
        o_valid    : out std_logic
    );
end entity quadrant_map;

architecture rtl of quadrant_map is
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
    signal r_x        : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_y        : std_logic_vector(G_DATA_WIDTH_NORM - 1 downto 0) := (others => '0');
    signal r_z        : signed(G_DATA_WIDTH_DENORM - 1 downto 0)         := (others => '0');
    signal r_quadrant : unsigned(1 downto 0)                             := (others => '0');
    signal r_valid    : std_logic                                        := '0';
begin
    -- ===================================================================
    o_x        <= r_x;
    o_y        <= r_y;
    o_z        <= std_logic_vector(r_z(o_z'range));
    o_quadrant <= std_logic_vector(r_quadrant);
    o_valid    <= r_valid;
    -- ===================================================================
    -- Quadrant Mapping
    -- Maps angle z into the principal quadrant [0, pi/2).
    p_quadrant_map : process (clk)
        variable v_z_signed : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
        variable v_z_in_f : real;
        variable v_z_reg_f : real;
        variable v_z_out_f : real;
    begin
        v_z_in_f := real(to_integer(signed(i_z)))/(2.0 ** G_DATA_WIDTH_FRAC);
        v_z_reg_f := real(to_integer(signed(r_z)))/(2.0 ** G_DATA_WIDTH_FRAC);
        v_z_out_f := real(to_integer(signed(r_z(o_z'range))))/(2.0 ** G_DATA_WIDTH_FRAC);
        if rising_edge(clk) then
            -------------
            -- PIPE 0
            -------------
            r_x     <= i_x(r_x'range);
            r_y     <= i_y(r_x'range);
            r_valid <= i_valid;

            v_z_signed := signed(i_z);

            if (v_z_signed >= 0) and (v_z_signed < C_MATH_PI_DIV_2_SIGNED) then
                r_quadrant <= "00";
                r_z        <= v_z_signed;
            elsif (v_z_signed >= C_MATH_PI_DIV_2_SIGNED) and (v_z_signed < C_MATH_PI_SIGNED) then
                r_quadrant <= "01";
                r_z        <= C_MATH_PI_SIGNED - v_z_signed;
            elsif (v_z_signed >= C_MATH_PI_SIGNED) and (v_z_signed < C_MATH_3_PI_DIV_2_SIGNED) then
                r_quadrant <= "10";
                r_z        <= v_z_signed - C_MATH_PI_SIGNED;
            else
                r_quadrant <= "11";
                r_z        <= C_MATH_2_PI_SIGNED - v_z_signed;
            end if;
        end if;
    end process p_quadrant_map;
    -- ===================================================================
end architecture;