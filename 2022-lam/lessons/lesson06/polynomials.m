%% Lesson 6a: Polynomials
% Before we step into z transform, we should take a look at what functions
% are there in MATLAB to evaluate polynomials. There are 4 major functions
% to know about -- polyval, root/poly and conv.
clc; clear; close all;

%% polyval
% Allows you to evaluate polynomials specified as an array of coefficients.
p = [2 -2 0 -3];     % 2x^3 - 2x^2 - 3
x = -5:.05:5;
a = polyval(p,x);
a2 = 2*x.^3 - 2*x.^2 - 3;

figure;
subplot(2, 1, 1);
plot(x, a);
title('Using polyval');

subplot(2, 1, 2);
plot(x, a2);
title('Using algebraic expression');
% The graphs are the same!

%% roots/poly
% These two functions are ~inverses! They allow you
% to find the roots / coefficients of a vector of numbers
r = roots(p);
p1 = poly(r);

% `poly` will always return a monic polynomial (the highest coefficient
% will be 1).

%% residue
% Will apply later in the Signals course. Pretty much partial fractions
% from Calc I.
b = [-4 8];
a = [1 6 8];
[r, p, k] = residue(b, a);

[bb, aa] = residue(r, p, k);  % can go both ways

% Note that a, b are row vectors, whereas r, p are column vectors! This
% convention is true when we look at tf/zpk forms.

%% conv
% You've probably heard this a lot from Prof. Fontaine.
% Convolution in the time domain is multiplication in the frequency domain
% (applying a LTI system to a signal is convolution in the time domain).
%
% Convolution is also used to multiply two polynomials together (if
% specified as an array of coefficients.)
a = [1 2 -3 4];
b = [5 0 3 -2];
p2 = conv(a, b);       % Use convolution

x = -5:.05:5;

% a little experiment
figure;
subplot(2, 1, 1);
plot(x, polyval(a, x) .* polyval(b, x));
title('Multiplying polynomial values elementwise');

subplot(2, 1, 2);
plot(x, polyval(p2, x));
title('Using conv on convolved polynomials');
