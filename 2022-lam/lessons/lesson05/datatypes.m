%% Lesson 5b: Datatypes
% There are several basic data types in MATLAB:
%
% - single, double (floating pt. 32 and 64 bit respectively)
% - int8, int16, int32, int64 (different size integers)
% - uint8, uint16, uint32, uint64 (different size unsigned intergers)
% - logicals
% - char arrays, strings
% - cell arrays

%%
% You can get the data type of a variable using the class function.

a = 10;
class(a)

%%
b = int8(a);
class(b)

%% Data Type Sizes
% Different data types take up different amounts of space in your memory
% and hard drive.  Let's take a look at some standard sizes in MATLAB.

clear
A = randn(1,'double');
B = randn(1,'single');
C = true(1);
D = 'D';

%%
whos                              % lists info of the variables in the current workspace

% If your data is getting to large, it can help to cast as a single.
% Logicals take up a whole byte.

%% Different Interpretations
% Be careful with what data types you feed into built in functions.
% MATLAB will have different responses to different types.

imshow(uint8(255*rand(128,128,3)))

%%
imshow(double(rand(128,128,3)))

%% Overflow and Underflow
% With floating point, we are trying to represent real numbers.  Obviously
% there must be some spacing between representable numbers, let's take a
% look.

L = logspace(-400,400,4096);
loglog(L,eps(L),single(L),eps(single(L)))

% As the plot proves, doubles have a much larger extent as well as more
% precision at each point.  Let's see how this applies in practice.

%%
eps(1)

%%
(1 + 0.5001*eps(1)) - 1   % Some rounding errors

%%
(1 + 0.4999*eps(1)) - 1

%%
1 + 1e16 == 1e16

%%
single(10^50)             % Overflow!

%%
single(10^-50)            % Underflow!

%%
uint8(256)

%%
int8(-129)

%% Cell Arrays
% Cell arrays are useful when you have data that is not well structured.
% However, it is also relatively slow and hard to deal with compared to
% matrices.  You should use them sparingly.

courses = {'', 'Modern Physics', 'Signals and Systems', ...
           'Complex Analysis', 'Drawing and Sketching for Engineers';...
           'Grades', 70 + 3*randn(132,1), 80 + 3*randn(41,1), ...
           40 + 3*randn(20,1), 100*ones(29,1);...
           'Teachers', {'Debroy';'Yecko'},{'Fontaine'},{'Smyth'},{'Dell'}}
       
%% Difference between {} and ()
courses(1,2)
courses{1,2}
courses{2,2}(3:5,1)
courses(3,2)
courses{3,2}
courses{3,2}{1}(1)

%% Objects and Classes
% MATLAB is an OOP language, the variety of toolboxes that MATLAB has
% (machine learning, filter, even fixed point numbers) are enclosed in
% classes. You might not need to write your own classes in your years of
% Cooper, but understanding how classes work in MATLAB would allow you to
% use those toolboxes effectively and efficiently.

x = randn(10000,1);
h = histogram(x);          % h is a histogram class

properties(h)

methods(h)

% Check out the documentation for more info on this histogram class and
% other classes

%% Structs and Objects
% Another thing you can write in MATLAB are your own structs. Structs are
% mini versions of objects. The main  difference is that objects have
% classes but structs do not. To make your own structs, you can do the
% following

sfield1 = 'a'; svalue1 = 5;
sfield2 = 'b'; svalue2 = [3 6];
sfield3 = 'c'; svalue3 = "Hello World";
sfield4 = 'd'; svalue4 = {'cell array'};

s = struct(sfield1,svalue1,sfield2,svalue2,sfield3,svalue3,sfield4,svalue4)

%%

s.a
s.b(2)

%% Struct with nonscalar cell array

tfield1 = 'f1';  tvalue1 = zeros(1,10);
tfield2 = 'f2';  tvalue2 = {'a', 'b'};
tfield3 = 'f3';  tvalue3 = {pi, pi.^2};
tfield4 = 'f4';  tvalue4 = {'fourth'};
t = struct(tfield1,tvalue1,tfield2,tvalue2,tfield3,tvalue3,tfield4,tvalue4)

%%
t(1)
t(2)

%%
% You can also create and fill a struct using dot notation
u = struct;
u.a = [1 3 5 7];
u.b = ["Hello","World!"];
u