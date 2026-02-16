-------------------------------------------------------------------------------
-- Post-Processing Bitshift
-- 
-- Implements a unified bitshift post-processing.
-- Note: if you want to implement a subset of the CORDIC functions and need a
-- simpler bitshift post-processing, reverse engineer this block and use the parts
-- needed for your specific CORDIC function. E.g., some of the states/if-cases are 
-- completely unecessary for a simple SIN/COS.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity postproc_bitshift is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_SHIFT_WIDTH       : natural := 5
    );
    port (
        clk : in std_logic;
        -- Config
        i_config  : in t_normalization;
        i_mode    : in t_mode;
        i_submode : in t_submode;
        -- Input 
        i_x          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_z          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_bitshift_x : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_bitshift_y : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_bitshift_z : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_valid      : in std_logic;
        -- Output
        o_x     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_z     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_valid : out std_logic
    );
end entity postproc_bitshift;

architecture rtl of postproc_bitshift is
    ----------------
    --  Functions
    ----------------
    function f_shift_by_signed (
        i_signed : signed;
        i_shift  : signed
    ) return signed is
    begin
        if (i_shift < 0) then
            return shift_right(i_signed, abs(to_integer(i_shift)));
        else
            return shift_left(i_signed, to_integer(i_shift));
        end if;
    end function;
    ----------------
    -- Constants
    ----------------
    ----------------
    -- Types
    ----------------
    type t_bitshift_state is (IDLE, CHECK_MODE, BITSHIFT_LINEAR, BITSHIFT_GEOMETRIC);

    ----------------
    -- Signals
    ----------------
    signal s_bitshift_state : t_bitshift_state := IDLE;
    signal r_mode           : t_mode           := ROTATIONAL;
    signal r_submode        : t_submode        := LINEAR;
    signal r_config         : t_normalization;
    signal r_x              : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_y              : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_z              : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := (others => '0');
    signal r_bitshift_x     : signed(G_SHIFT_WIDTH - 1 downto 0)       := (others => '0');
    signal r_bitshift_y     : signed(G_SHIFT_WIDTH - 1 downto 0)       := (others => '0');
    signal r_bitshift_z     : signed(G_SHIFT_WIDTH - 1 downto 0)       := (others => '0');
    signal r_total_shift_xz : signed(G_SHIFT_WIDTH downto 0)           := (others => '0');
    signal r_total_shift_yx : signed(G_SHIFT_WIDTH downto 0)           := (others => '0');
    signal r_valid          : std_logic                                := '0';
begin
    -- ===================================================================
    -- Combinatorial
    o_x     <= std_logic_vector(r_x);
    o_y     <= std_logic_vector(r_y);
    o_z     <= std_logic_vector(r_z);
    o_valid <= r_valid;
    -- ===================================================================
    p_range_reduce_denorm : process (clk)
    begin
        if rising_edge(clk) then
            -- Default
            r_valid <= '0';
            case s_bitshift_state is
                    -------------------------------------------
                when IDLE =>
                    r_mode       <= i_mode;
                    r_submode    <= i_submode;
                    r_config     <= i_config;
                    r_x          <= signed(i_x);
                    r_y          <= signed(i_y);
                    r_z          <= signed(i_z);
                    r_bitshift_x <= signed(i_bitshift_x);
                    r_bitshift_y <= signed(i_bitshift_y);
                    r_bitshift_z <= signed(i_bitshift_z);
                    if (i_valid = '1') then
                        s_bitshift_state <= CHECK_MODE;
                    end if;
                    -------------------------------------------
                when CHECK_MODE =>
                    r_total_shift_xz <= resize(r_bitshift_x, G_SHIFT_WIDTH + 1) + resize(r_bitshift_z, G_SHIFT_WIDTH + 1);
                    r_total_shift_yx <= resize(r_bitshift_y, G_SHIFT_WIDTH + 1) - resize(r_bitshift_x, G_SHIFT_WIDTH + 1);
                    if (r_submode = LINEAR) then
                        s_bitshift_state <= BITSHIFT_LINEAR;
                    else
                        s_bitshift_state <= BITSHIFT_GEOMETRIC;
                    end if;
                    -------------------------------------------
                when BITSHIFT_LINEAR =>
                    if (r_mode = ROTATIONAL) then
                        -- MULTIPLICATION : Y = X * Z
                        -- Reconstruct Y by adding shifts of X and Z
                        r_x <= f_shift_by_signed(r_x, r_bitshift_x);
                        r_y <= f_shift_by_signed(r_y, r_total_shift_xz);
                        r_z <= f_shift_by_signed(r_z, r_bitshift_z);
                    else
                        -- VECTORING
                        -- DIVISION : Z = Y / X
                        -- Reconstruct Z by subtracting shifts (Y_shift - X_shift)
                        r_x <= f_shift_by_signed(r_x, r_bitshift_x);
                        r_y <= f_shift_by_signed(r_y, r_bitshift_y);
                        r_z <= f_shift_by_signed(r_z, r_total_shift_yx);
                    end if;
                    r_valid          <= '1';
                    s_bitshift_state <= IDLE;
                    -------------------------------------------
                when BITSHIFT_GEOMETRIC =>
                    if (r_config.norm_shift_double = '1') then
                        -- Note : this is only really applicable to Mode.VECTORING but its w/e atm (just set correct Normalization)
                        -- Assuming common shift was applied to X

                        -- This is basically a half_shift = shift_x // 2
                        r_x <= f_shift_by_signed(
                            r_x,
                            r_bitshift_x(r_bitshift_x'high) & r_bitshift_x(r_bitshift_x'high downto r_bitshift_x'low + 1)
                            );
                        r_y <= f_shift_by_signed(
                            r_y,
                            r_bitshift_x(r_bitshift_x'high) & r_bitshift_x(r_bitshift_x'high downto r_bitshift_x'low + 1)
                            );
                    else
                        -- Standard Vector Scaling (uniform scaling of X,Y)
                        r_x <= f_shift_by_signed(r_x, r_bitshift_x);
                        r_y <= f_shift_by_signed(r_y, r_bitshift_y);
                    end if;
                    r_valid          <= '1';
                    s_bitshift_state <= IDLE;
                    -------------------------------------------
                when others =>
                    s_bitshift_state <= IDLE;
                    -------------------------------------------
            end case;
        end if;
    end process p_range_reduce_denorm;
    -- ===================================================================
end architecture;