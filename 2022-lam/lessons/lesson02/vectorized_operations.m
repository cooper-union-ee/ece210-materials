%% Lesson 2a: More vector and matrix operations
%
% Objectives:
% * Understand how to perform vector operations in MATLAB
% * Understand arithmetic and basic functions in MATLAB

%% Vector operations
% In lesson 1, we saw how to create a vector with the colon operator and
% linspace. Now let's perform some operations on them!
% 
% There are two common classes of operations that you can perform on
% vectors: element-wise operations (which produce another vector) and
% aggregate operations (which produce a scalar value). There are also many
% functions that don't fall under these categories, but these cover many of
% the common functions.

%% Element-wise operations
% Many operations that work on scalars (which are really degenerate
% matrices) also work element-wise on vectors (or matrices).
x = 0:0.01:2*pi;    % Create a linearly-spaced vector
y = sin(x);         % sin() works element-wise on vectors!
y = abs(x);         % same with abs()!
y = x .^ 4;         % element-wise power
y = power(x, 4);    % same as above

plot(x, y);         % Plot y vs. x (line graph)
title('y vs. x');

%% Aggregate operations
% Another common class of operations produce a single output or statistic
% about a vector (or matrix).
length(x);              % number of elements in x
sum(x);                 % sum of the elements of x
mean(x);                % average of the elements of x
min(x);                 % minimum element of x
diff(x);                % difference between adjacent elements of x

%% Exercise 1 : Vector operations
T = 1e-6;           % Sampling period (s)
t = 0:T:2e-3;       % Time (domain/x-axis)
f0 = 50;            % Initial frequency (Hz)
b = 10e6;           % Chirp rate (Hz/s)
A = 10;             % Amplitude
y1 = A * cos(2*pi*f0*t + pi*b*t.^2);

figure;
plot(t,y1);

%% Exercise: Numerical calculus
% See numerical_calculus.m.

%% Basic indexing in MATLAB
% The process of extracting values from a vector (or matrix) is called
% "indexing." In MATLAB, indices start at 1, rather than 0 in most
% languages (in which it is more of an "offset" than a cardinal index).

%% Exercise 2 : Basic indexing
% The syntax for indexing is "x(indices)", where x is the variable to
% index, and indices is a scalar or a vector of indices. There are many
% variations on this. Note that indices can be any vector
x(1);                   % first element of x
x(1:3);                 % elements 1, 2 and 3 (inclusive!)
x(1:length(x));         % all elements in x
x(1:end);               % same as above
x(:);                   % same as above
x(end);                 % last element of x
x(3:end);               % all elements from 3 onwards
x([1,3,5]);             % elements 1, 3, and 5 from x

x(1:2:end);             % all odd-indexed elements of x
ind = 1:2:length(x);
x(ind);                 % same as the previous example

%% Exercises to improve your understanding
% Take some time to go through these on your own.
x([1,2,3]);             % Will these produce the same result?
x([3,2,1]);

x2 = 1:5;
x2(6);                  % What will this produce?
x2(0);                  % What will this produce?
x2(1:1.5:4);            % What will this produce?
ind = 1:1.5:4;
x2(ind);                % What will this produce?

z = 4;
z(1);                   % What will this produce?

%% Matrix operations
% Matrices is closely related to vectors, and we have also explored some
% matrix operations last class. This class, we are going to explore
% functions that are very useful but are hard to grasp for beginners,
% namely reshape, meshgrid, row-wise and column-wise operations.

%% Reshape
% Change a matrix from one shape to another. The new shape has to have the
% same number of elements as the original shape.
%
% When you are reshaping an array / matrix, the first dimension is filled
% first, and then the second dimension, so on and so forth. I.e., elements
% start filling down columns, then rows, etc.
M = 1:100;
N1 = reshape(M,2,2,[]);    % It would create a 2*2*25 matrix
N2 = reshape(M,[2,2,25]);  % Same as N1
N2(:,:,25);                % Gives you 97,98,99,100
N2(:,1,25);                % Gives you 97 and 98

%% Meshgrid
% Meshgrid is quite hard to understand. Think of it as a way to replicate
% arrays, like the following example:
a = 1:3;
b = 1:5;
[A,B] = meshgrid(a,b);

%% Using meshgrid for functions of multiple variables
% You have created two arrays A and B, note that in A, the vector a is
% copied row-wise, while the vector b is transposed and copied column-wise.
% This is useful, because when you lay one above the other, you essentially
% create a CARTESIAN PRODUCT, and it is useful when we need to plot a 3D
% graph.
% 
% Here is a more complicated example to show you when meshgrid is useful
a1 = -2:0.25:2;
b1 = a1;
[A1,B1] = meshgrid(a1);

% Here we plot the surface of f(x) = x*exp^(x.^2+y.^2)
F = A1.*exp(-A1.^2-B1.^2);
surf(A1, B1, F);

%% Broadcasting: an alternative to meshgrid
% Broadcasting, like meshgrid, can be used as a way to write functions of
% multiple variables, without generating the intermediate matrices A and B.
% The way this works is that operations performed on a set of N orthogonal
% vectors will automatically generate an N-dimensional result.
% 
% See the following example, which recreates the above example. Note that
% b1 is transposed.
F2 = a1.*exp(-a1.^2-(b1.').^2);
surf(A1, B1, F2);

% Check that this matches the previous result.
error = rms(F - F2, 'all');

% Note: broadcasting doesn't generate the domains A1 and B1,
% so meshgrid() is more useful when we need to supply the domain to a
% function like mesh() or surf(). But when we only need the result,
% broadcasting is somewhat simpler.
%
% For homework assignments that require functions of multiple variables,
% use whichever method is more intuitive to you.

%% Row-wise / Column-wise operations
% Vector operations can also be performed on matrices. We can perform a
% vector operation on each row/column of a matrix, or on a particular
% row/column by indexing.
H = magic(4);    % create the magical matrix H
sum(H,1);        % column wise sum, note that this is a row vector(default)
fliplr(H);       % flip H from left to right
flipud(H);       % flip H upside down
H(1,:) = fliplr(H(1,:)); % flip only ONE row left to right
H(1,:) = [];     % delete the first row

%% Exercise 7 : Matrix Operations
H2 = randi(20,4,5);   % random 4x5 matrix with integers from 1 to 20
sum(H2(:,2));
mean(H2(3,:));
C = reshape(H2,2,2,5);
C(2,:,:) = [];