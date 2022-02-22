%% Lesson 4c: Classes
% Objected-oriented programming is a powerful paradigm. We can model
% real-world entities as "objects" of a type defined by a "class."
% This is a very convenient and intuitive way to structure large programs.

clear; clc; close all;

%% A basic class
% See BasicClass.m for the class definition.
x = 1:10;
a = BasicClass(x);          % runs the BasicClass constructor to 
                            % create a BasicClass object
y = a.findClosest(5.4);     % runs the method findClosest;
                            % this is called "dot indexing"

%%
z = a.vals;                 % Doesn't work, properties are private

%%
z = a.getVals();            % Have to use this getter
