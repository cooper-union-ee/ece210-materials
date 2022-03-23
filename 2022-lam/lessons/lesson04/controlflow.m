%% Lesson 4b: Control Sequences
%
% Like any general purpose programming language, MATLAB has control flow
% constructs (if, loops, etc.). Sometimes we cannot achieve everything
% using a linear set of instructions and vectorization, such as for
% complex simulations.

clear; clc; close all;

%% For loops (A review)
total=0;
for i=1:10
    total = total + i;
end
total

%% If...Else Statements
gpa = 2.3;
if gpa < 2
    fprintf('You are in DANGER!!!\n')
elseif gpa >= 2 && gpa < 3.5
    fprintf('You are safe.\n')
elseif gpa >= 3.5 && gpa < 3.7
    fprintf('Cum Laude\n')
elseif gpa >= 3.7 && gpa < 3.8
    fprintf('Magna Cum Laude\n')
elseif gpa >= 3.8 && gpa < 4
    fprintf('Summa Cum Laude\n')
else
    fprintf("invalid gpa\n")
end

%% While loop
% Iterate while a condition is true, as opposed to iterating over a vector.
total = 0;
i = 0;
while i <= 10
    total = total + i;
    i = i+1;
end
total

%% Try and Catch blocks
% Try and catch allow for error handling, which can be useful when using
% user-supplied input that may be invalid. See the documentation of any
% function to see what errors it may throw.
%
% It is also a good idea for you to validate input if writing a function
% intended to be used by other people. This is very common in all MATLAB
% builtin/toolbox functions.
try
    a = [1 2; 3 4];
    b = [1 2 3 4];
    c = a*b          % Can't do this! not the same dimensions!
catch err
    fprintf('You are trying to do something which is not allowed\n');
end