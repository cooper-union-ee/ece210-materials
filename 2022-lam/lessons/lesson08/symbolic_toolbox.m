%% Symbolic Toolbox
% MATLAB is typically associated with computing *numerical* solutions
% (i.e., estimating solutions using floating point calculations), we
% may often want to compute *analytic* solutions (exact solutions,
% often represented by formulas).
%
% Wolfram Mathematica is a premier example of technical software with
% support for symbolic computation, but we can achieve many useful
% symbolic calculations in MATLAB using the *symbolic toolbox*.
%
% The symbolic toolbox is useful if you want to represent an abstract
% expression. You can think of a symbolic calculation as storing the
% structure of expressions to operate on rather than the values
% themselves.
clear; clc; close all;

%% Create symbolic variables
syms x z;

%% Creating expressions
v = x + 2;
w = x * z;

%% Substituting expressions into a symbolic expression
subs(v, x, 3);

% You can also substitute symbolic expressions, not only values.
syms r;
subs(w, z, r);

%% Solve a symbolic equation for a variable
% You may want to look at the documentation page for the `solve` function.
% If the expression cannot be solved analytically, MATLAB will default
% to using a numerical solver.
solve(x + 3 == 5, x);

syms a b c;
solve(a*x^2 + b*x + c, x);

% Solving multiple variables simultaneously
eqs = [x + z == 14, x - z == 6];
soln = solve(eqs, [x z]);
soln.x;
soln.z;

%% Set "assumptions" (constraints) on a variable
% This is the shorthand syntax for setting assumptions on symbolic objects.
% See also the `assume` function.
syms n positive;
solve(n^2 == 4, n);

%% Simplify an expression
% This attempts to simplify an expression using known
% mathematical identities.
simplify(exp(log(x)));

% See also `simplifyFraction` for more efficient simplification
% of fractions only.

%% Collect
% This collects coefficients of like terms together.
collect((x + 2) * (x + 3), x);

%% Combine
% tries to rewrite products of powers in the expression as a single power
combine(x^4 * x^3);

% Has other options such as 'log' and 'sincos'

%% Expand
% Similar to `collect`, but expands all variables. More or less the
% inverse of `combine`.
expand((x + 5)^3);

%% Partial fraction decomposition
partfrac((x^7+x^2)/(x^3 - 3*x + 2))

%% poly2sym and sym2poly
p = [1 2 3 4];
psym = poly2sym(p, x);
q = sym2poly(psym);

%% Symbolic functions
% Symbolic functions are like symbolic expressions but with a formal
% parameter rather than all free parameters. This may be useful for
% substituting for a symbolic variable or for differential equations.
syms f(y);
f(y) = y^2;
f(4);

%% Compose symbolic functions
syms g(y)
g(y) = sin(y);
h = compose(f, g);

%% Symbolic function inverse
f(y) = exp(y);
finverse(f)

%% Symbolic differentiation
% Note that this `diff` is different from the `diff` from before.
% This one is actually `sym.diff`.
syms x y z;
v = x^2 + 16*x + 5;
dvdx = diff(v);
dvdx_3 = subs(dvdx, x,3);

%% Partial differentiation
% This function assumes derivatives commute (i.e., second partials exist
% and are continuous).
w = -x^3 + x^2 + 3*y + 25*sin(x*y);
dwdx = diff(w, x);
dwdy = diff(w, y);

% third order derivative w.r.t. x
dw3dx3 = diff(w, x, 3);

% Vector operations exist as well such as: curl, divergence, gradient,
% laplacian, jacobian, hessian...

%% Differential equations
syms y(t) a;
dsolve(diff(y) == a*y, t);
dsolve(diff(y) == a*y, y(0) == 5);    % with initial conditions

%% Symbolic integration
v = x^2 + 16*x + 5;
V = int(v);

%% Definite integral
syms a b;
Vab = int(v, a, b);
V01 = int(v, 0, 1);

%% z transform
syms a n z;
f = a^n;
ztrans(f);

%% Symbolic matrices
syms m;
n = 4;
A = m.^((0:n)'*(0:n));
D = diff(A);

%% Laplace Transform
syms t a s;
f = exp(-a*t);
laplace(f);

%% Inverse Laplace Transform
ilaplace(-4*s+8/(s^2+6*s+8));

%% Fourier Transform
f = dirac(x) + sin(x);
fourier(f);

%% Inverse Fourier Transform
syms w;

% fourier transform of cosine(t)
expr = dirac(w+1) + dirac(w-1);
ift = ifourier(expr);
simplify(ift);

%% Note: performance
syms x v;
v = x^3 + 5*x^2 - 3*x + 9;
t = 1:1e4;

tic;
X = t.^3 + 5*t.^2 - 3*t + 9;
toc;

tic;
Y = subs(v,x,t);
toc;

% Symbolic computation and data structures are relatively expensive
% when compared to numerical operations! Use sparingly!
