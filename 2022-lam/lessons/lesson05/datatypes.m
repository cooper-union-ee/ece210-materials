%% Lesson 5b: Datatypes
% There are several basic data types in MATLAB:
%
% - single, double (floating pt. 32 and 64 bit respectively)
% - int8, int16, int32, int64 (different size integers)
% - uint8, uint16, uint32, uint64 (different size unsigned intergers)
% - logicals
% - char arrays, strings
% - cell arrays
clc; clear; close all;

%% What type is this?
% You can get the data type of a variable using the class function. Most
% of the time, values default to fp64, which is often good for
% scientific computing with high accuracy.
a = 10;
class(a);

b = int8(a);
class(b);

%% Data Type Sizes
% Different data types take up different amounts of space in your memory
% and hard drive.  Let's take a look at some standard sizes in MATLAB.
A = randn(1, 'double');
B = randn(1, 'single');
C = true(1);
D = 'D';

% lists info of the variables in the current workspace
whos;

% If your data is getting too large, it can help to cast to smaller types.
% `single` is a smaller fp type, and uint8/uint16 are smaller

%% Different Interpretations
% Be careful with what data types you feed into built in functions.
% MATLAB will have different responses to different types.

% imshow with ints
imshow(uint8(rand(128, 128, 3)));

%%
% imshow with doubles
imshow(double(rand(128, 128, 3)));

%% Overflow and Underflow
% With floating point, we are trying to represent real numbers.  Obviously
% there must be some spacing between representable numbers using a
% fixed-size representation. Let's take a look.
%
% eps() shows the error between a number and its true value given IEEE
% floating-point.
L = logspace(-400, 400, 4096);
loglog(L, eps(L), single(L), eps(single(L)));

% As the plot shows, doubles have a much larger range as well as higher
% precision at each point.  Let's see how this applies in practice.

%% More examples examples of eps
eps(1);
(1 + 0.5001*eps(1)) - 1;
(1 + 0.4999*eps(1)) - 1;

eps(1e16);
1 + 1e16 == 1e16;

%% More examples of overflow/underflow
single(10^50);
single(10^-50);

uint8(256);
int8(-129);

%% Cell Arrays
% Matrices can only store values of the same type (homogenous data).
% Cell arrays can store heterogeneous (but still rectangular) data. 
% However, they are relatively slow and should be used sparingly.
courses = {
    '', 'Modern Physics', 'Signals and Systems', ...
    'Complex Analysis', 'Drawing and Sketching for Engineers'; ...

    'Grades', 70 + 3*randn(132,1), 80 + 3*randn(41,1), ...
    40 + 3*randn(20,1), 100*ones(29,1); ...
    
    'Teachers', {'Debroy'; 'Yecko'}, {'Fontaine'}, {'Smyth'}, {'Dell'}
};
       
%% Difference between {} and ()
% As we've seen before, () performs matrix indexing. A cell array behaves
% as a matrix of cell-arrays; indexing it using () will also produce a cell
% array.
%
% {} performs matrix indexing, and also extracts the values of the cell(s).
% Usually, this is what you want when immediately indexing a cell array.
%
% Confusingly (or not?) you can double-index cell arrays using `{}`, but
% you cannot double-index matrices using `()`.
courses(1,2);
courses{1,2};
courses{2,2}(3:5,1);
courses(3,2);
courses{3,2};
courses{3,2}{1}(1);

%% Objects and Classes
% MATLAB supports OOP programming. We saw a basic class definition last
% class. Classes are also used in all of MATLAB's toolboxes (e.g., ML,
% signal processing).
x = randn(10000, 1);
h = histogram(x);          % h is a histogram class

properties(h);
methods(h);

% Check out the documentation for more info on the histogram class and
% other classes.

%% Structs and Objects
% MATLAB also supports `struct`s. Structs are like objects in that they
% can combine multiple values under the same variable (composite data),
% and use the same dot-indexing syntax. However, they are not defined by
% and constructed using a class, but rather using the `struct` constructor.

sfield1 = 'a'; svalue1 = 5;
sfield2 = 'b'; svalue2 = [3 6];
sfield3 = 'c'; svalue3 = "Hello World";
sfield4 = 'd'; svalue4 = {'cell array'};

s = struct( ...
    sfield1, svalue1, ...
    sfield2, svalue2, ...
    sfield3, svalue3, ...
    sfield4, svalue4 ...
);

s.a;
s.b(2);

%% Struct with cell array fields
% Cell arrays as struct fields may be used to generate an array of structs.
tfield1 = 'f1';  tvalue1 = zeros(1,10);
tfield2 = 'f2';  tvalue2 = {'a', 'b'};
tfield3 = 'f3';  tvalue3 = {pi, pi.^2};
tfield4 = 'f4';  tvalue4 = {'fourth'};
t = struct( ...
    tfield1, tvalue1, ...
    tfield2, tvalue2, ...
    tfield3, tvalue3, ...
    tfield4, tvalue4 ...
);

t(1);
t(2);

%% Adding fields to a struct
% Struct fields are not fixed; you can add fields to it after it is
% constructed using dot-indexing.
u = struct;
u.a = [1 3 5 7];
u.b = ["Hello","World!"];
u;