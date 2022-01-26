%% Numerical estimation of integrals and derivatives
% Numerical integration and differentiation are a staple of numerical
% computing. We will now see how easy these are in MATLAB!
clc; clear; close all;

%% The diff and cumsum functions
% Note the lengths of z, zdiff, and zcumsum! (Fencepost problem)
z = [0 5 -2 3 4];
zdiff = diff(z);
zcumsum = cumsum(z);

%% Setup: A simple function
% Let's start with a simple example: y = x.^2. The domain is N points 
% linearly sampled from lo to hi.
lo = -2;
hi = 2;
N = 1e2;

x = linspace(lo, hi, N);
y = x.^2;
plot(x, y);
title('x^2');

%% Numerical (Approximate) Derivatives
% We can calculate a difference quotient between each pair of (x,y) points
% using the diff() function.
dydx = diff(y)./diff(x);    % difference quotient

figure();
plot(x(1:end-1), dydx);

%% Numerical (Approximate) Integrals
% Now suppose we want to approximate the cumulative integral (Riemann sum)
% of a function.
xdiff = diff(x);
dx = xdiff(1);              % spacing between points
dx = (hi-lo) / (N-1);       % alternative to the above (note: N-1)

Y = cumsum(y) * dx;         % Riemann sum

figure();
plot(x, Y);

%% Error metrics: Check how close we are!
% dydx should be derivative of x.^2 = 2*x
dydx_actual = 2 * x;

% Y should be \int_{-2}^{x}{t.^2 dt}
Y_actual = (x .^3 - (-2)^3) / 3;

% Slightly more accurate -- can you figure out why?
% Y_actual = (x .^3 - (-2-dx)^3) / 3;

% Error metric: MSE (mean square error) or RMSE (root mean square error)
% Try changing N and see how the error changes. Try this with both the
% integral and derivative.

% estimated = dydx;
% actual = dydx_actual(1:end-1);
estimated = Y;
actual = Y_actual;
mse = mean((estimated - actual) .^ 2);
rmse = rms(estimated - actual);

%% Fundamental Theorem of Calculus
% Now, use the approximate derivative to get the original function, y back 
% as yhat and plot it.  You may need to use/create another variable for
% the x axis when plotting.
figure();
yhat = diff(Y)./diff(x);    % differentiate Y
plot(x(1:end-1), yhat);

figure();
yhat2 = cumsum(dydx) * dx;  % integrate dydx
plot(x(1:end-1), yhat2);