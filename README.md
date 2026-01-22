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
a fixed set of angles until a condition is met, we can calculate different functions. The initialization
and iteration rules are important, as those dictate the function obtained. In rotation mode we can
calculate the sine and cosine of an angle. 
Given an angle Theta, we can find the X and Y coordinate corresponding to it. One would initialize the vector v0 with

>> v0 = [1, 0]

Usually, in the first iteration the vector is rotated with +45 degrees. Successive iterations rotate the vector in ever-decreasing
steps until the condition is met, e.g. angle is found. The step size is chosen to be:

>> Z_i = arctan(2^(-i))  for i = 0,1,2,...

due to a simplification one can do further down. Keep reading! 
In formal words, each iteration v_(i+1) performs a rotation on the initialization vector v_i by R_i. The rotation matrix R_i is:

>> R_i = [[cos(Z_i), -sin(Z_i)], [sin(Z_i), cos(Z_i)]]

Simplifying this yields:

>> R_i = cos(Z_i) [[1, -tan(Z_i)], [tan(Z_i), 1]]

Here one simplify! By setting the angle such that tan(Z_i) = +-2^(-i) will still yield a series that converges to
every possible output value, whilst the above expression can be severily simplified:

>> R_i = cos(arctan(2^(-i))) * [[1, -d*2^-i], [d*2^-i, 1]]

where 'd' determines the sign and therefore direction of the rotation.

       +1, if Z_i > 0
>> d = 
       -1, if Z_i < 0

The first term looks problematic. Fear not! A trigonometic allow further simplification:

>> cos(Z_i) = 1/sqrt(1 + tan(Z_i)^2)

Using this on the term yields:

>> K_i = cos(arctan(2^-i)) = 1/sqrt(1 + 2^(-2*i))

This is the "processing gain" and can be taken out of the iterative process to be added later.

>> K(n) = product(K_i, start=0, end=n-1) ~= 0.607

By pre-correcting with 1/K (~= 1.645), one can avoid correction altogether. To obtain the angle through
the algorithm, the iterative angle is kept track of and iterated via:

>> theta_i+1 = theta_i - (d * Z_i)

Note here that the whole algorithm boils down to adds/subtracts & right-shifts.
Usually, the preset iterative values are stored in a LUT along with any correction values.

A rule-of-thumb for the number of iterations is "1 iteration per bit of valid input data", so 16-bits ==> >15 iterations

-----------------------------------------------------------------------------------------
I view it as the following: there are 2 main modes and 3 sub-modes. Below I present the modes and then a general algorithm.

> Vectoring mode: 
Finds the angle theta of an input X/Y by moving the init vector's Y-component to zero through iterations, where each iteration
adds/subtracts a preset angle to the initialized theta value. The sign of the addition is determined by the sign of the Y-axis value.
The final result is angle B and K*x0, where K is the gain. An obvious use of this to transform rectangular to polar coordinates, or to
calculate arctan, arcsin & arccos. 

> Rotational mode: 
Finds the X/Y given an angle theta by rotating the init vector's angle to the same angle as the input vector's in ever-decreasing steps. It does this
by moving the input vector's angle to zero.

> Circular mode:
    x_(i+1) = x_i - (y_i * d_i * 2^-i) 
    y_(i+1) = y_i - (x_i * d_i * 2^-i) 
    z_(i+1) = z_i - d_i * arctan(2^-i)

        +1, if (y_i < c)
    d = 
        -1, if (y_i >= c)

    i = 0,1,2,3,...,n-1

> Linear mode:
    x_(i+1) = x_i - (0 * d_i * 2^-i)
            = x_i
    y_(i+1) = y_i + (x_i * d_i * 2^-i) 
    z_(i+1) = z_i - (d_i * 2^-i)

        +1, if (y_i < 0)
    d = 
        -1, if (y_i >= 0)

    i = 0,1,2,3,...,n-1
    
> Hyperbolic mode:
    x_(j+1) = x_j + (y_j * d_j * 2^-j)
    y_(i+1) = y_j + (x_j * d_j * 2^-j) 
    z_(i+1) = z_i - d_i * arctanh(2^-j)

        +1, if (y_i < 0)
    d = 
        -1, if (y_i >= 0)

    j = i + 1 (due to j=0 causing undefined behaviour)

    Note: the 4th value must be repeated twice in order for tan to converge. This also holds for j = 13, and every j=3k+1 value where k is the previous repetition index

-----------------------------------------------------------------------------------------
> A general CORDIC algorithm:
    x_(i+1) = x_i - (m * y_i * d_i * a_i)
    y_(i+1) = y_i + (x_i * d_i * a_i) 
    z_(i+1) = z_i - (d_i * a_i)


Here 'm', 'd' & 'a' are dependent on what mode we are in.

>> Rotation:
d_i = -sign(z_i)

>> Vectoring:
d_i = -sign(y_i)

>> Circular:
m = 1
a_i = arctan(2^-i) (stored in LUT)
i = 0,1,2,...,n
A_n = 1/K_n ~ 0.60725

>> Linear
m = 0
a_i = 2^-i
i = 0,1,2,...,n
A_n = 1/K_n = 1

>> Hyperbolic
m = -1
a_i = arctanh(2^-j) (stored in LUT)
j = 1,2,3,4,4,5,6,...,13,13,...,3k+1
A_n = 1/K_n ~ 0.82816
-----------------------------------------------------------------------------------------



Linear Vectoring Mode:
Keeps the X-component OR Y-component constant and changes the other component AND the angle to obtain different results.
The desired result is found in the angular result.

----------------
> TEMPLATE: 
----------------

----------------
> Sin(x): 
----------------


----------------
> Cos(x): 
----------------

----------------
> Tan(x): 
----------------

----------------
> Multiplication: 
----------------
bla bla bla

----------------
> Division: 
----------------
Let the init vector be (x_0, y_0, z_0) = (x, y, z). The algorithm is:

x_(i+1) = x_i - 0 * d * (2^-i) = x_i
y_(i+1) = y_i + x_i * d * (2^-i)
z_(i+1) = z_i - d * (2^-i)

and 
    +1, if y_i < 0
d = 
    -1, if y_i > 0

The output will then be:
x_n = x_0
y_n = 0
x_n = z_0 + y_0/x_0

------------------
Hyperbolic functions
------------------

Makes use of the fact that A = theta/2 for a circle with radius 1 (x^2 + y^2 = 1), and the
same holds for the hyperbolic function (x^2 - y^2 = 1), i.e. phi = 2*A 

>> sinh(x) = (exp(x) - exp(-x))/2
>> cosh(x) = (exp(x) + exp(-x))/2
>> tanh(x) = (exp(x) - exp(-x))/(exp(x) + exp(-x))


-------------------------------
Inverse Hyperbolic functions
-------------------------------
One needs to store the iterative angle steps (45, 26.565... ) to bring the Y-component down to 0. 
One needs to store the iterative atanh steps (31.47, 14.63...) to iterate the angular Z. 
In other words, store two sets of angular steps.
Note: we need to repeat step 4 twice (!) in order for arctanh to converge
Note: the iterator is 'j' = i + 1. This is due to i = 0 being undefined for arctanh(2^-i)


arctanh(x):
