-------------------
CORDIC Algorithm
-------------------

Stands for Coordinate Rotation Digital Computer. Based on a small rotation 2x2 matrix it can do a whole bunch of functions, 
such as:

- Trigonometic functions
- Exponential functions
- Multiply & division
- Square root
- ...


The theory is the following:

            A
       _____|_____
      /     |     \                        
     /      |      \                    
    |       |       |                  
----|-------|-------|-------->
    |       |       |
     \      |      /
      \_____|_____/
            |                          
                                      
CORDIC is built upon rotations on the unit circle. By rotating an initialized vector through
a fixed set of angles until a condition is met, we can calculate different functions. The initialization and iteration rules are important, as those dictate the function obtained. In rotation mode we can calculate the sine and cosine of an angle. 
Given an angle Theta, we can find the X and Y coordinate corresponding to it. One would initialize the vector v0 with

<font color="green"> v0 = [1, 0] </font>

Usually, in the first iteration the vector is rotated with +45 degrees. Successive iterations rotate the vector in ever-decreasing steps until the condition is met, e.g. angle is found. The step size is chosen to be:

<font color="green"> Z_i = arctan(2^(-i))  for i = 0,1,2,... </font>

due to a simplification one can do further down. Keep reading! 
In formal words, each iteration v_(i+1) performs a rotation on the initialization vector v_i by R_i. The rotation matrix R_i is:

<font color="green"> R_i = [[cos(Z_i), -sin(Z_i)], [sin(Z_i), cos(Z_i)]] </font>

Simplifying this yields:

<font color="green"> R_i = cos(Z_i) [[1, -tan(Z_i)], [tan(Z_i), 1]] </font>

But there's more! By setting the angle such that tan(Z_i) = +-2^(-i) the equation will still yield a series that converges to every possible output value, whilst the above expression can be heavily simplified:

<font color="green"> R_i = cos(arctan(2^(-i))) * [[1, -d*2^-i], [d*2^-i, 1]] </font>

where 'd' determines the sign and therefore direction of the rotation.

<font color="green"> >> d = +1 if (Z_i > 0) else -1 </font>

The first term looks problematic. Fear not! A trigonometic allow further simplification:

<font color="green"> cos(Z_i) = 1/sqrt(1 + tan(Z_i)^2) </font>

Using this on the term yields:

<font color="green"> K_i = cos(arctan(2^-i)) = 1/sqrt(1 + 2^(-2*i)) </font>

This is the "processing gain" and can be taken out of the iterative process to be added later.

<font color="green"> K(n) = product(K_i, start=0, end=n-1) ~= 0.607 </font>

By pre-correcting with 1/K (~= 1.645), one can avoid correction altogether. To obtain the angle through the algorithm, the iterative angle is kept track of and iterated via:

<font color="green"> theta_i+1 = theta_i - (d * Z_i) </font>

Note here that the whole algorithm boils down to adds/subtracts & right-shifts. Usually, the preset iterative values are stored in a LUT along with any correction values.

A rule-of-thumb for the number of iterations is "1 iteration per bit of valid input data", so 16-bits ==> >15 iterations

-----------------------------------------------------------------------------------------
I view it as the following: there are 2 main modes and 3 sub-modes. Below I present the modes and then a general algorithm.

There are two modes:

**Vectoring mode:**
Finds the angle theta of an input X/Y by moving the init vector's Y-component to zero through iterations, where each iteration
adds/subtracts a preset angle to the initialized theta value. The sign of the addition is determined by the sign of the Y-axis value.
The final result is angle Z=B, Y=0 and X=K*x0, where K is the gain. An obvious use of this to transform rectangular to polar coordinates, or to calculate arctan(), arcsin() & arccos(). 

**Rotational mode:**
Finds the X/Y given an angle theta by rotating the init vector's angle to the same angle as the input vector's in ever-decreasing steps. It does this by moving the input vector's angle to zero.


There are 3 sub-modes:

**Circular mode:**

    x_(i+1) = x_i - (y_i * d_i * 2^-i) 
    y_(i+1) = y_i - (x_i * d_i * 2^-i) 
    z_(i+1) = z_i - d_i * arctan(2^-i)

        +1, if (y_i < c)
    d = 
        -1, if (y_i >= c)

    i = 0,1,2,3,...,n-1

**Linear mode:**

    x_(i+1) = x_i - (0 * d_i * 2^-i) = x_i
    y_(i+1) = y_i + (x_i * d_i * 2^-i) 
    z_(i+1) = z_i - (d_i * 2^-i)

        +1, if (y_i < 0)
    d = 
        -1, if (y_i >= 0)

    i = 0,1,2,3,...,n-1
    
**Hyperbolic mode:**

    x_(j+1) = x_j + (y_j * d_j * 2^-j)
    y_(i+1) = y_j + (x_j * d_j * 2^-j) 
    z_(i+1) = z_i - d_i * arctanh(2^-j)
        +1, if (y_i < 0)
    d = 
        -1, if (y_i >= 0)

j = i + 1 (due to j=0 causing undefined behaviour)

**Note:** the 4th value must be repeated twice in order for tan to converge. This also holds for j = 13, and every j=3k+1 value where k is the previous repetition index

-----------------------------------------------------------------------------------------
## A general CORDIC algorithm:

    x_(i+1) = x_i - (m * y_i * d_i * a_i)
    y_(i+1) = y_i + (x_i * d_i * a_i) 
    z_(i+1) = z_i - (d_i * a_i)


Here 'm', 'd' & 'a' are dependent on what mode we are in.

**Rotation:**
    
    d_i = -sign(z_i)

**Vectoring:**

    d_i = -sign(y_i) * sign(x_i)

**Circular:**

    m   = 0
    a_i = arctan(2^-i) (stored in LUT)
    i   = 0,1,2...n
    A_n = 1/K_n ~ 0.60725

**Linear:**

    m   = 0
    a_i = 2^-i
    i   = 0,1,2...n
    A_n = 1/K_n = 1

**Hyperbolic:**

    m    = 1
    a_i  = arctanh(2^-j) (stored in LUT)
    j    = 1,2,3,4,4,5,6,...,13,13,...,3k+1
    A_n  = 1/K_n ~ 0.82816
-----------------------------------------------------------------------------------------
# Normalization
The CORDIC algorithm will not converge for very large values. Usually we want values within the range [0, 2), otherwise we risk ending up at a wrong value (similar to how hyperbolic needs index-stuttering to converge). But such a small input range seems very limiting, right? Below are three techniques to normalize the input:

**Bitshift normalization:** Suitable for value where we depend on X and Y. Simply shifts the values down to a suitable range and after the CORDIC iterations it shift the output back up. There are caveats to this - read the code!

**Range reduction:** Suitable for angles (e.g.in radians) to normalize it by seeing how many times log(2) fits in the input, and then reconstructing it afterwards. We also have support for range reconstruction, where we use Euler identities to reconstruct SINH(), COSH() and TANH(), 

**Quadrant Map:** Self-explanatory. We only converge in the first quadrant, so everything is mapped there and then un-mapped after the iterating is done.

> Trivia: The normalization schemes took almost as long as the CORDIC algorithm for me to implement...


# Finally...
In /scripts/model/ you will find a full-fledged CORDIC algorithm model in Python along the the microcodes later used in the VHDL implementation.

In /scripts/ you will find "microcodes.json" based on the Python model. There it is described how to achieve multiple mathematical functions via the CORDIC algorithm, and the normalization schemes used to converge.

It is beneficial to check out /scripts/synth_and_test/utils.py to see how I mapped the reference data and input generator. There we see what values to expect and on what port, along with what values we are expected to input.

In /test/run.py we have self-checking testbenches that compare the output data to the reference model with a precision of 1e-4 (varies with bit size).

> Known limitations: There are some places in the VHDL code that uses to_signed(), to_unsigned(), to_integer() and thus is bounded to 32-bit size. It is an easy fix, but I am too lazy as of writing to fix it.

If you wish to use a subset of the CORDIC algorithms: 
1. Check the microcodes.json for what you need
2. Grab the iterator.vhd, the relevant pre-proc and post-proc blocks and initializers. 