
--================================================================================================
-- Generated via Jinja2 Template through ../scripts/synth_and_test/generate_microcodes.py
--================================================================================================
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
-- 
use work.cordic_pkg.all;
-- 
package cordic_microcode_pkg is
    -----------------------
    -- Constant Pool
    -----------------------
    constant C_CONSTANT_POOL_SIZE : natural := 6;
    type t_offset_pool is array (0 to C_CONSTANT_POOL_SIZE - 1) of signed(26 downto 0);

    constant C_OFFSET_POOL : t_offset_pool := (
        0 => "000000000000000000000000000", -- 0.0
        1 => "010000000000000000000000000", -- 1.0
        2 => "000101110101010000101001000", -- 0.36451172962
        3 => "111010001010101111010111000", -- -0.36451172962
        4 => "110000000000000000000000000", -- -1.0
        5 => "001000000000000000000000000", -- 0.5
        others => (others => '0')
    );

    -----------------------
    -- Function PTR table
    -----------------------
    constant C_NBR_OF_FUNCTIONS : natural := 23;

    type t_function_array is array (0 to C_NBR_OF_FUNCTIONS - 1) of unsigned(5 downto 0);

    constant C_FUNCTION_ARRAY : t_function_array := (
        0 => to_unsigned(0, 6), -- SIN_COS
        1 => to_unsigned(1, 6), -- TAN
        2 => to_unsigned(3, 6), -- ARCTAN
        3 => to_unsigned(4, 6), -- MULT
        4 => to_unsigned(5, 6), -- DIV
        5 => to_unsigned(6, 6), -- RECIPROCAL
        6 => to_unsigned(7, 6), -- SINH_COSH
        7 => to_unsigned(8, 6), -- TANH
        8 => to_unsigned(10, 6), -- ARCTANH
        9 => to_unsigned(11, 6), -- SQRT
        10 => to_unsigned(12, 6), -- LN
        11 => to_unsigned(14, 6), -- EXP
        12 => to_unsigned(15, 6), -- POW
        13 => to_unsigned(18, 6), -- ARCCOSH
        14 => to_unsigned(22, 6), -- ARCSINH
        15 => to_unsigned(26, 6), -- CSC
        16 => to_unsigned(28, 6), -- SEC
        17 => to_unsigned(30, 6), -- COT
        18 => to_unsigned(33, 6), -- SECH
        19 => to_unsigned(35, 6), -- CSCH
        20 => to_unsigned(37, 6), -- COTH
        21 => to_unsigned(40, 6), -- ARCSIN
        22 => to_unsigned(42, 6) -- ARCCOS
    );

    -----------------------
    -- Microcode ROM
    -----------------------
    constant C_MICROCODE_ROM_SIZE : natural := 44;
    constant C_MICROCODE_ROM : t_microcode_step_array(0 to C_MICROCODE_ROM_SIZE - 1) := (
        -- Sine & Cosine step 1/1 (Note: functions as 'POL2REC')
        0 => (
            mode    => ROTATIONAL,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => PROC_GAIN, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '1'
            ),
            last => '1'
        ),
        
        -- Tan step 1/2
        1 => (
            mode    => ROTATIONAL,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => PROC_GAIN, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '1'
            ),
            last => '0'
        ),
        
        -- Tan step 2/2
        2 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- Arctan step 1/1 (Note: functions as 'REC2POL')
        3 => (
            mode    => VECTORING,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- MULT step 1/1
        4 => (
            mode    => ROTATIONAL,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '0', -- Y
                    2 => '1'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- DIV step 1/1
        5 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- RECIP step 1/1
        6 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- SINH_COSH step 1/1
        7 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '1',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- TANH step 1/2
        8 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '1',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- TANH step 2/2
        9 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- ARCTANH step 1/1
        10 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- SQRT step 1/1
        11 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(2, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(3, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '1',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- LN step 1/2
        12 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(4, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- LN step 2/2
        13 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => CONST, 
                    const_id => to_unsigned(5, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- EXP step 1/1
        14 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '1',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- POW step 1/3
        15 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(4, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- POW step 2/3 (note: Z needs to be 2x the required value)
        16 => (
            mode    => ROTATIONAL,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '0', -- Y
                    2 => '1'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- POW step 3/3
        17 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '1',
                reduction_reconstruct => '1',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- ARCCOSH step 1/4
        18 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCCOSH step 2/4
        19 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCCOSH step 3/4
        20 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(4, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCCOSH step 4/4
        21 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => CONST, 
                    const_id => to_unsigned(5, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- ARCSINH step 1/4
        22 => (
            mode    => VECTORING,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCSINH step 2/4
        23 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => PROC_GAIN_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCSINH step 3/4
        24 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(4, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCSINH step 4/4
        25 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => CONST, 
                    const_id => to_unsigned(5, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- CSC step 1/2
        26 => (
            mode    => ROTATIONAL,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => PROC_GAIN, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '1'
            ),
            last => '0'
        ),
        
        -- CSC step 2/2
        27 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- SEC step 1/2
        28 => (
            mode    => ROTATIONAL,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => PROC_GAIN, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '1'
            ),
            last => '0'
        ),
        
        -- SEC step 2/2
        29 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- COT step 1/3
        30 => (
            mode    => ROTATIONAL,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => PROC_GAIN, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '1'
            ),
            last => '0'
        ),
        
        -- COT step 2/3
        31 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- COT step 3/3
        32 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '1',
                norm_input => (
                    0 => '1', -- X
                    1 => '1', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- SECH step 1/2
        33 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- SECH step 2/2
        34 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- CSCH step 1/2
        35 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- CSCH step 2/2
        36 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- COTH step 1/3
        37 => (
            mode    => ROTATIONAL,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => PROC_GAIN_HYP_INV, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => INPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- COTH step 2/3
        38 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_Y, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- COTH step 3/3
        39 => (
            mode    => VECTORING,
            submode => LINEAR,
            init    => (
                0 => (
                    source   => OUTPUT_Z, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => CONST, 
                    const_id => to_unsigned(1, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- ARCSIN step 1/2
        40 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(2, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(3, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCSIN step 2/2
        41 => (
            mode    => VECTORING,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        ),
        
        -- ARCCOS step 1/2
        42 => (
            mode    => VECTORING,
            submode => HYPERBOLIC,
            init    => (
                0 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(2, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => INPUT_Y, 
                    const_id => to_unsigned(3, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '0'
        ),
        
        -- ARCCOS step 2/2
        43 => (
            mode    => VECTORING,
            submode => CIRCULAR,
            init    => (
                0 => (
                    source   => INPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- X
                1 => (
                    source   => OUTPUT_X, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ), -- Y
                2 => (
                    source   => CONST, 
                    const_id => to_unsigned(0, integer(ceil(log2(real(C_NBR_OF_FUNCTIONS)))))
                    ) -- Z
            ),
            norm => (
                -- Bitshift Norm
                norm_en    => '0',
                norm_input => (
                    0 => '0', -- X
                    1 => '0', -- Y
                    2 => '0'  -- Z
                ),
                norm_shift_double   => '0',
                norm_shift_common   => '0',
                -- Range Reduce
                reduction_en          => '0',
                reduction_reconstruct => '0',
                -- Quadrant Map
                quadrant_en           => '0'
            ),
            last => '1'
        )
        
    );


end package;