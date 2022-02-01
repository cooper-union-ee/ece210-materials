%% Lesson 3b: Functions
%
% Objectives:
% - Explore MATLAB's function-calling syntax and semantics.
% - Explore anonymous functions.
% - Explore local functions.
% - Explore regular functions.
clear; clc; close all;

%% Functions
% Functions in any programming language are the means of abstraction.
% In functional programming, they are a fundamental structure with the
% power to build any complex form. In imperative and scientific computing,
% functions are useful to prevent code duplication and improve
% maintainability.
%
% There are a few varieties of MATLAB, each of which has very different
% syntax and semantics, so buckle up!
%
% (Insider information from MathWorks: MATLAB is working on
% improving the support/accesibility of functional programming! So there
% may be some improvements in the near future!)
%
% Note: this lecture was heavily modified by a functional-programming fan!

%% Using functions
% All functions are called (invoked) in the same manner: by using the
% function's name followed by the list of parameters with which to invoke
% the function.
z = zeros(1, 3);
mean([1, 2, 3, 4, 5]);

% Functions may have optional parameters, and they may behave differently
% when called with different inputs (polymorphism) or when different
% numbers of outputs are expected. They may also return zero, one, or 
% multiple values.
size1 = size(z);
size2 = size(z, 2);     % optional second parameter

hist(1:10);             % displays a historgram
a = hist(1:10);         % stores a histogram into the variable a, and does
                        % not display a histogram

[r1, r2] = HelloWorld("Jon", "Lam");    % Function returning multiple
                        % values (HelloWorld defined later in file)

% There is a second way that you've seen to call functions, called "command
% syntax." These are translatable to the regular function syntax. Any
% textual arguments in this syntax will be interpreted as strings, which is
% similar to UNIX sh commands arguments (hence "command" syntax).
clear a b;              % clear("a", "b")
close all;              % close("all")
mkdir test;             % mkdir("test")
rmdir test;             % rmdir("test")

% Note that if a function takes no arguments, the parentheses may also be
% omitted. (This is not true for anonymous functions, as we will see.)
clc;                    % clc()
figure;                 % figure()

%% Anonymous functions
% Anonymous functions are defined with the following syntax:
%
% @(arg1, arg2, ...) fun_body
%
% These allow us to conveniently define functions inline, and perform some
% functional programming capabilities. In other programming languages, they
% may be known as "arrow functions" or "lambda functions."
cube = @(x) x.^3;
parabaloid = @(x, y) x.^2 + y.^2;

% Call these functions like any other function.
cube(3);
parabaloid(3, 4);

% As the name suggests, anonymous functions don't have to be assigned
% names; by themselves, they are "function values" or "function
% expressions" and can be handled like any other expression. (I.e.,
% "first-class" functions). Usually, we assign it to a variable to name it,
% just as we do for most useful expressions.
@(x) x.^3;
cube_fnval = ans;

% Anonymous functions can capture variables from the surrounding scope.
% They may exist anywhere an expression may exist (e.g., within the body of
% another function).
outside_variable = 3;
capture_fn = @() outside_variable;
outside_variable = 4;

capture_fn;                     % What will this return?
capture_fn();                   % What will this return?

% Lexical scoping and closures apply! This allows for some degree of
% functional programming (e.g., function currying).
curried_sum = @(x) @(y) x + y;
add_two = curried_sum(2);
add_two(5);                     % The binding x <- 2 is captured in
                                % add_two's lexical closure

% add_two(2)(5)                 % Can't do this due to MATLAB's syntax,
                                % just like how you can't double-index
                                % an expression

%% Example: Higher-order functions
% An example of passing functions around like any other variable.
% (Functions that accept other functions as parameters or return a function
% are called "higher-order functions.")
%
% In this example, compose is the function composition operator.
% compose(f,g) = (f o g). It is a HOF because it takes two functions as
% parameters, and it returns a function.
compose = @(f, g) @(x) f(g(x));
add_three = @(x) x + 3;
times_four = @(x) x * 4;
x_times_four_plus_three = compose(add_three, times_four);

x = 0:10;
y = x_times_four_plus_three(x);
plot(x, y);
grid on;

%% Normal Functions
% "Normal functions" (so-called because they were the first type of
% function in MATLAB) are defined using the syntax shown below, and are
% invoked in the same way as anonymous functions.
%
% Note that normal functions cannot be passed around as variables, and this
% makes a functional-programming style impossible using normal functions.
%
% Unlike anonymous functions, normal functions may include multiple
% statements, may return multiple values, are invoked if appearing in an
% expression without parentheses, and do not capture variables from the
% surrounding scope/workspace.
%
% There are two types of normal functions: "public" normal functions, which
% must be placed at the beginning of a *.m file with the same name as the
% function, or local/private normal functions, which may appear at the end
% of a *.m file (after anything that is not a function). Both types of
% normal functions must appear after any statements in the file; in other
% words, a file defining a non-local function can only contain a list of
% function definitions, the first of is public and the rest of which are
% private. As the name suggests, local functions are only in scope in the
% file in which they are defined, whereas public functions may be
% accessible if they are on the MATLAB path.
%
% You don't need to understand all this right now; this brief explanation 
% and the MATLAB documentation can serve as a reference for your future 
% MATLAB endeavors.

%% The MATLAB Path
% In order to call a public function defined in another file, the function
% file must be in the current folder or on the MATLAB path.
matlabpath;                 % Print out MATLAB path

%% Invoking regular functions
% Note that this section is before the local function definition because
% the local function must be defined after all statements in the script.
%
% distance() is a public function defined in the file distance.m
% HelloWorld() is a local function defined below
distance(3, 4);
HelloWorld("Jon", "Lam");   % Invoking HelloWorld and ignoring outputs

%% Defining a local function
function [res1, res2] = HelloWorld(name1, name2)
    fprintf("Hello, world! %s %s\n", name1, name2);
    res1 = 3;
    res2 = [5 6];
end
