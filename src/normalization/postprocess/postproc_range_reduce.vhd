-------------------------------------------------------------------------------
-- Post-Processing Range Reduce
-- 
-- Implements a range reconstruction post-processing.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
entity postproc_range_reduce is
    generic (
        G_DATA_WIDTH_DENORM : natural := 35;
        G_DATA_WIDTH_FRAC   : natural := 30;
        G_SHIFT_WIDTH       : natural := 5;
        G_RANGE_N_WIDTH     : natural := 10
    );
    port (
        clk : in std_logic;
        -- Config
        i_config  : in t_normalization;
        i_mode    : in t_mode;
        i_submode : in t_submode;
        -- Input 
        i_x    : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_y    : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        -- Note : for SINH_COSH the Z represents exp(Z). We use N later to
        -- shift everything to a correct value. The integer width decides
        -- how much we can shift it. Thus, the largest Z is decided by how
        -- many integer bits we have available times ln(2).
        i_z          : in std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        i_bitshift_x : in std_logic_vector(G_SHIFT_WIDTH - 1 downto 0);
        i_range_n    : in std_logic_vector(G_RANGE_N_WIDTH - 1 downto 0);
        i_valid      : in std_logic;
        -- Output
        o_x     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_y     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_z     : out std_logic_vector(G_DATA_WIDTH_DENORM - 1 downto 0);
        o_valid : out std_logic
    );
end entity postproc_range_reduce;

architecture rtl of postproc_range_reduce is
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
    constant C_LN2_REAL   : real                                     := 0.6931471806;
    constant C_LN2_SIGNED : signed(G_DATA_WIDTH_DENORM - 1 downto 0) := to_signed(integer(C_LN2_REAL * (2.0 ** (G_DATA_WIDTH_FRAC))), G_DATA_WIDTH_DENORM);
    ---------
    -- Types
    ----------------
    type t_bitshift_state is (IDLE, CHECK_MODE, VEC_HYPER_RECONSTRUCT, REDUCTION_REVERSE, REDUCTION_RECONSTRUCT);

    ----------------
    -- Signals
    ----------------
    signal s_reduce_state : t_bitshift_state := IDLE;
    signal r_mode         : t_mode           := ROTATIONAL;
    signal r_submode      : t_submode        := LINEAR;
    signal r_config       : t_normalization;
    signal r_valid        : std_logic                            := '0';
    signal r_bitshift_x   : signed(G_SHIFT_WIDTH - 1 downto 0)   := (others => '0');
    signal r_range_n      : signed(G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');

    -- Correction values
    signal r_vec_hyp_ln2   : signed(G_DATA_WIDTH_DENORM + G_SHIFT_WIDTH - 1 downto 0)   := (others => '0');
    signal r_reduction_ln2 : signed(G_DATA_WIDTH_DENORM + G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');

    -- Reconstruct values
    signal r_exp_pos_n : signed(G_DATA_WIDTH_DENORM downto 0)                           := (others => '0');
    signal r_exp_neg_n : signed(G_DATA_WIDTH_DENORM downto 0)                           := (others => '0');
    signal r_exp_pos_z : signed(G_DATA_WIDTH_DENORM + 1 + G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');
    signal r_exp_neg_z : signed(G_DATA_WIDTH_DENORM + 1 + G_RANGE_N_WIDTH - 1 downto 0) := (others => '0');

    -- Latch and resize inputs
    signal r_x : signed(G_DATA_WIDTH_DENORM + 1 + G_RANGE_N_WIDTH downto 0)                 := (others => '0');
    signal r_y : signed(G_DATA_WIDTH_DENORM + 1 + G_RANGE_N_WIDTH downto 0)                 := (others => '0');
    signal r_z : signed(maximum(r_vec_hyp_ln2'length, r_reduction_ln2'length) - 1 downto 0) := (others => '0');
begin
    -- ===================================================================
    -- Combinatorial
    o_x     <= std_logic_vector(r_x(o_x'range));
    o_y     <= std_logic_vector(r_y(o_y'range));
    o_z     <= std_logic_vector(r_z(o_z'range));
    o_valid <= r_valid;
    -- ===================================================================
    process (clk)
    begin
        if rising_edge(clk) then
            r_valid <= '0';
            case s_reduce_state is
                when IDLE =>
                    -- Latch input
                    r_mode       <= i_mode;
                    r_submode    <= i_submode;
                    r_config     <= i_config;
                    r_x          <= resize(signed(i_x), r_x'length);
                    r_y          <= resize(signed(i_y), r_y'length);
                    r_z          <= resize(signed(i_z), r_z'length);
                    r_bitshift_x <= signed(i_bitshift_x);
                    r_range_n    <= signed(i_range_n);
                    -- Calculate reconstruction values
                    r_vec_hyp_ln2   <= C_LN2_SIGNED * shift_right(signed(i_bitshift_x), 1);
                    r_reduction_ln2 <= C_LN2_SIGNED * signed(i_range_n);
                    r_exp_pos_n     <= resize(signed(i_x), G_DATA_WIDTH_DENORM + 1) + resize(signed(i_y), G_DATA_WIDTH_DENORM + 1);
                    r_exp_neg_n     <= resize(signed(i_x), G_DATA_WIDTH_DENORM + 1) - resize(signed(i_y), G_DATA_WIDTH_DENORM + 1);
                    if (i_valid = '1') then
                        s_reduce_state <= CHECK_MODE;
                    end if;
                    ----------------------------------------------------------
                when CHECK_MODE =>
                    if (r_mode = VECTORING) and (r_submode = HYPERBOLIC) then
                        s_reduce_state <= VEC_HYPER_RECONSTRUCT;
                    else
                        s_reduce_state <= REDUCTION_REVERSE;
                    end if;
                    ---------------------------------------------
                when VEC_HYPER_RECONSTRUCT =>
                    r_z            <= r_z + r_vec_hyp_ln2;
                    r_valid        <= '1';
                    s_reduce_state <= IDLE;
                    ---------------------------------------------
                when REDUCTION_REVERSE =>
                    r_z         <= r_z + r_reduction_ln2;
                    r_exp_pos_z <= f_shift_by_signed(
                        resize(r_exp_pos_n, r_exp_pos_z'length),
                        r_range_n
                        );
                    r_exp_neg_z <= f_shift_by_signed(
                        resize(r_exp_neg_n, r_exp_neg_z'length),
                        - r_range_n
                        );
                    if (r_config.reduction_reconstruct = '1') then
                        s_reduce_state <= REDUCTION_RECONSTRUCT;
                    else
                        r_valid        <= '1';
                        s_reduce_state <= IDLE;
                    end if;
                    ---------------------------------------------
                when REDUCTION_RECONSTRUCT =>
                    r_x <= shift_right(
                        resize(r_exp_pos_z, r_x'length) + resize(r_exp_neg_z, r_x'length),
                        1
                        );
                    r_y <= shift_right(
                        resize(r_exp_pos_z, r_y'length) - resize(r_exp_neg_z, r_y'length),
                        1
                        );
                    r_valid        <= '1';
                    s_reduce_state <= IDLE;
                    ---------------------------------------------
                when others =>
                    s_reduce_state <= IDLE;
                    ----------------------------------------------------------
            end case;
        end if;
    end process;
    -- ===================================================================
end architecture;