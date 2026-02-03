-- ===========================================================================
-- CORDIC Iterator
-- 
-- Implements the circular, linear and hyperbolic calculation iterations
-- ===========================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.cordic_pkg.all;

entity iterator is
   generic (
      G_DATA_WIDTH          : natural := 32;
      G_DATA_FRAC_WIDTH     : natural := 30;
      G_NBR_OF_ITERATIONS   : natural := 40;
      G_INIT_FILEPATH_CIRC  : string  := "../../data/angle_circ_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt";
      G_INIT_FILEPATH_HYPER : string  := "../../data/angle_hyper_0_" & integer'image(G_NBR_OF_ITERATIONS - 1) & ".txt"
   );
   port (
      clk : in std_logic;
      -- Config
      i_mode    : t_mode;
      i_submode : t_submode;
      -- Input
      i_data_x      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
      i_data_y      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
      i_data_z      : in std_logic_vector(G_DATA_WIDTH - 1 downto 0);
      i_data_tvalid : in std_logic;
      -- Output
      o_data_x      : out std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
      o_data_y      : out std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
      o_data_z      : out std_logic_vector(G_DATA_WIDTH + integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0);
      o_data_tvalid : out std_logic
   );
end entity iterator;

architecture rtl of iterator is
   -- ---------------
   -- Constants
   -- ---------------
   constant C_WIDTH_GROWTH : integer                           := integer(ceil(log2(real(G_NBR_OF_ITERATIONS))));
   constant C_SIGNED_ONE   : signed(G_DATA_WIDTH - 1 downto 0) := (G_DATA_WIDTH - 2 => '1', others => '0'); -- hmm

   -- ---------------
   -- Types
   -- ---------------
   type t_operation_state is (IDLE, SHIFT, ADD, INCR, READ);
   -- ---------------
   -- Signals
   -- ---------------
   signal s_operation    : t_operation_state                                                             := IDLE;
   signal r_iter         : unsigned(integer(ceil(log2(real(G_NBR_OF_ITERATIONS)))) - 1 downto 0)         := (others => '0');
   signal r_iter_stutter : unsigned(integer(ceil(log2(real(3 * G_NBR_OF_ITERATIONS + 1)))) - 1 downto 0) := to_unsigned(4, integer(ceil(log2(real(3 * G_NBR_OF_ITERATIONS + 1)))));

   -- Calculations
   signal r_shift_x : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_shift_y : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_shift_z : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_iter_x  : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_iter_y  : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_iter_z  : signed(G_DATA_WIDTH + C_WIDTH_GROWTH - 1 downto 0) := (others => '0');
   signal r_sign    : std_logic                                          := '0';

   -- Memory
   signal w_circ_angle  : std_logic_vector(G_DATA_WIDTH - 1 downto 0);
   signal w_hyper_angle : std_logic_vector(G_DATA_WIDTH - 1 downto 0);

begin
   -- ===================================================================
   -- Angle ROM
   circular_rom_inst : entity work.angle_rom
      generic map(
         G_DATA_WIDTH    => G_DATA_WIDTH,
         G_DATA_DEPTH    => G_NBR_OF_ITERATIONS,
         G_INIT_FILEPATH => G_INIT_FILEPATH_CIRC
      )
      port map
      (
         clk     => clk,
         i_raddr => std_logic_vector(r_iter),
         o_rdata => w_circ_angle
      );

   hyperbolic_rom_inst : entity work.angle_rom
      generic map(
         G_DATA_WIDTH    => G_DATA_WIDTH,
         G_DATA_DEPTH    => G_NBR_OF_ITERATIONS,
         G_INIT_FILEPATH => G_INIT_FILEPATH_HYPER
      )
      port map
      (
         clk     => clk,
         i_raddr => std_logic_vector(r_iter),
         o_rdata => w_hyper_angle
      );
   -- ===================================================================
   -- Main
   p_iterate : process (clk)
      variable v_iter_x_float  : real;
      variable v_iter_y_float  : real;
      variable v_iter_z_float  : real;
      variable v_shift_x_float : real;
      variable v_shift_y_float : real;
      variable v_shift_z_float : real;
   begin
      if rising_edge(clk) then
         case s_operation is
               -- ---------------------------------------------
            when IDLE                 =>
               r_iter         <= (others => '0');
               r_iter_x       <= resize(signed(i_data_x), r_iter_x'length);
               r_iter_y       <= resize(signed(i_data_y), r_iter_y'length);
               r_iter_z       <= resize(signed(i_data_z), r_iter_z'length);
               r_iter_stutter <= to_unsigned(4, r_iter_stutter'length);
               if (i_data_tvalid = '1') then
                  s_operation <= SHIFT;
               end if;
               -- ---------------------------------------------
            when SHIFT =>
               -- Y
               r_shift_y <= shift_right(r_iter_x, to_integer(r_iter));
               -- X/Z
               if (i_submode = LINEAR) then
                  r_shift_x <= (others => '0');
                  r_shift_z <= - resize(shift_right(C_SIGNED_ONE, to_integer(r_iter)), r_shift_z'length);
               elsif (i_submode = CIRCULAR) then
                  r_shift_x <= - shift_right(r_iter_y, to_integer(r_iter));
                  r_shift_z <= - resize(signed('0' & w_circ_angle), r_shift_z'length);
               elsif (i_submode = HYPERBOLIC) then
                  r_shift_x <= shift_right(r_iter_y, to_integer(r_iter + 1));
                  r_shift_y <= shift_right(r_iter_x, to_integer(r_iter + 1));
                  r_shift_z <= - resize(signed('0' & w_hyper_angle), r_shift_z'length);
               end if;

               s_operation <= ADD;
               -- ---------------------------------------------
            when ADD =>
               -- DEBUG
               -- synthesis translate_off
               v_shift_x_float := real(to_integer(r_shift_x)) / (2.0 ** G_DATA_FRAC_WIDTH);
               v_shift_y_float := real(to_integer(r_shift_y)) / (2.0 ** G_DATA_FRAC_WIDTH);
               v_shift_z_float := real(to_integer(r_shift_z)) / (2.0 ** G_DATA_FRAC_WIDTH);
               -- synthesis translate_on
               -- Add
               if (r_sign = '1') then
                  r_iter_x <= r_iter_x - r_shift_x;
                  r_iter_y <= r_iter_y - r_shift_y;
                  r_iter_z <= r_iter_z - r_shift_z;
               else
                  r_iter_x <= r_iter_x + r_shift_x;
                  r_iter_y <= r_iter_y + r_shift_y;
                  r_iter_z <= r_iter_z + r_shift_z;
               end if;

               s_operation <= INCR;
               -- ---------------------------------------------
            when INCR =>
               -- DEBUG
               -- synthesis translate_off
               v_iter_x_float := real(to_integer(r_iter_x)) / (2.0 ** G_DATA_FRAC_WIDTH);
               v_iter_y_float := real(to_integer(r_iter_y)) / (2.0 ** G_DATA_FRAC_WIDTH);
               v_iter_z_float := real(to_integer(r_iter_z)) / (2.0 ** G_DATA_FRAC_WIDTH);
               -- synthesis translate_on
               -- State check
               if (r_iter >= G_NBR_OF_ITERATIONS - 1) then
                  r_iter      <= (others => '0');
                  s_operation <= IDLE;
               else
                  r_iter <= r_iter + 1;
                  -- Stutter Handle
                  if (i_submode = HYPERBOLIC) and (r_iter + 1 >= r_iter_stutter) then
                     r_iter         <= r_iter;
                     r_iter_stutter <= shift_left(r_iter_stutter, 1) + r_iter_stutter + 1; -- 3k+1
                  end if;
                  s_operation <= READ;
               end if;
               -- ---------------------------------------------
            when READ =>
               s_operation <= SHIFT;
               -- ---------------------------------------------
            when others =>
               s_operation <= IDLE;
               -- ---------------------------------------------
         end case;
      end if;
   end process p_iterate;
   -- ===================================================================
   -- Sign Evaluation
   p_sign : process (clk)
   begin
      if rising_edge(clk) then
         if (i_mode = ROTATIONAL) then
            r_sign <= r_iter_z(r_iter_z'high);
         else
            -- VECTORING
            -- r_sign <= not(r_iter_y(r_iter_z'high) and r_iter_x(r_iter_x'high));
            r_sign <= not(r_iter_y(r_iter_z'high));
         end if;
      end if;
   end process p_sign;
   -- ===================================================================
   -- Combinatorial
   -- TODO hmm what about range
   o_data_x      <= std_logic_vector(r_iter_x);
   o_data_y      <= std_logic_vector(r_iter_y);
   o_data_z      <= std_logic_vector(r_iter_z);
   o_data_tvalid <= '1' when (r_iter >= G_NBR_OF_ITERATIONS - 1) and (s_operation = INCR) else
      '0';
   -- ===================================================================
   p_ovf_and_saturate : process (clk)
   begin
      if rising_edge(clk) then
         null;
      end if;
   end process p_ovf_and_saturate;
   -- ===================================================================

end architecture;