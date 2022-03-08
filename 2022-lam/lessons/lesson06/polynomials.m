%% Lesson 6a: Polynomials
% Before we step into z transform, we should take a look at what functions
% are there in MATLAB to evaluate polynomials. There are 4 major functions
% to know about -- polyval, root/poly and conv.

%% polyval
% Allows you to evaluate polynomials at specified values
p = [2 -2 0 -3]     % 2x^3 - 2x^2 - 3
x = -5:.05:5;
a = polyval(p,x);
a2 = 2*x.^3 - 2*x.^2 - 3;

figure
subplot(2,1,1);
plot(x,a)
title('Using polyval')
hold on;
subplot(2,1,2);
plot(x,a2)
title('Using algebraic expression')
% The graphs are the same!

%% roots/poly
% These two functions are ~inverses! They allow you
% to find the roots / coefficients of a vector of numbers
r = roots(p)
p1 = poly(r)

%% residue
% Will apply later in the Signals course. Pretty much partial fractions
% from Calc I.

b = [-4 8];
a = [1 6 8];
[r,p,k] = residue(b,a)

[bb,aa] = residue(r,p,k)  % can go both ways

%% conv
% If Fontaine's talked about it, you mostly heard of convolution when you
% multiply in the frequency domain, i.e. when you feed a signal through a
% system, you need to multiply in the frequency domain. It is also used
% when you MULTIPLY TWO POLYNOMIALS TOGETHER!!!

%%
a = [1 2 -3 4];
b = [5 0 3 -2];
p2 = conv(a,b)       % Use convolution

x = -5:.05:5;

% a little experiment
figure
subplot(2,1,1);
plot(x,polyval(a,x).*polyval(b,x))
title('Multiplying polynomial values')
hold on;
subplot(2,1,2);
plot(x,polyval(p2,x))
title('Using conv on coefficients')
