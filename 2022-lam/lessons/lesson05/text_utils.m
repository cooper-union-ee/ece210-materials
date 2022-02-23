%% Lesson 5c: Character Arrays and Strings
% We just learned about different data types. We will focus on two data
% structures that are very similar in function: strings and character
% arrays. They are often interchangeable, but there are some nuances.
clear; clc; close all;

%% Character arrays as text
% Note that MATLAB uses UTF-16 for its character encoding (not ASCII); this
% means two bytes per character (type `char`).
str = 'Hello, world!';
whos;

%% Charracter arrays as matrices
% Character arrays are regular arrays/matrices, and characters have
% numeric values. (This is very similar to in C.) In fact, the character
% array syntax is syntactic sugar. The following two are equivalent.
str1 = 'Hi';
str2 = ['H', 'i'];

% This means you can index and concatenate character arrays just like you
% would strings, and you can cast characters to numbers.
stem(uint16(str));                  % Treating characters as numbers
title([str '''s Numeric Code']);    % `horcat` on character arrays

% Note that we escape a single quote inside a character array using double
% single quotes. Be careful! What do you think the following will do?
[''''];
['' ''];
'''';
% '' '';

%% sprintf
% The sprintf function is useful in formatting strings to be output like
% you would in C.
numberOfStudents = 20;
section = 'B';
averageGrade = mean(40 + randn(numberOfStudents, 1));
sprintf(['There are %d students in physics section %s with ' ...
    'an average grade of %0.2f'], numberOfStudents, section, averageGrade);

%% fprintf
% fprintf is like sprintf but either outputs to a file if specified,
% otherwise stdout.
fprintf(['There are %d students in physics section %s with ' ...
    'an average grade of %0.2f\n'], ...
    numberOfStudents, section, averageGrade);
    
%% Character arrays are ordinary (rectangular) matrices
% legends = ['sin(x)'; 'cos(x)'; '3x'];
legends = ['sin(x)'; 'cos(x)'; 'tan(x)'];
          
%% Compound character arrays using cell arrays
% What if we want a matrix/array/set of strings? We previously saw that
% horizontally or vertically concatenating character arrays will not work.
%
% One thing we can do is to use cell arrays, but this introduces the
% annoyances of cell arrays.
legends1 = {'sin(x)', 'cos(x)', '3x'};

% Alternatively, we can have a matrix of singleton cell arrays containing a
% character array.
legends2 = [{'sin(x)'}, {'cos(x)'}, {'3x'}];

%% The `string` datatype
% Like many high-level languages (i.e., basically any modern language),
% MATLAB has a dedicated atomic `string` type. These may be constructed
% using a literal enclosed in double quotes, or by using the `string`
% constructor.
legends3 = [string('sin(x)'), "cos(x)", "3x"];

%% This works!
% This works with either legends1, legends2, or legends3.
plot(rand(10, 3));
legend(legends3);

%% Indexing string and string arrays with curly braces
% Indexing a string: a string acts like a singleton cell array
% containing a character array.
str3 = "Hello, world";
% str3(2);                      % fails
str3{1}(2);

% Indexing a string array: a string array acts like a cell array of
% character arrays (for compatability reasons).
legends(3);
legends{3}(2);

% Confusing! In general, you can stick with strings and string arrays and
% not have to worry about cell arrays at all, but this may help your
% understanding if a weird scenario comes up.

%% Sample string manipulation
% Using split, you can separate strings into a cell array or string array
% based on certain qualifications, most commonly whitespace.
t = ['The rain in Spain stays' newline 'mainly in the plain.']

split(t);                       % Splits words by default
split(t,'n');

% You can also return the delimiters if you want
[cellArray, delimiters] = split(t, {'n' 'h'});

% In a similar fashion, you can search for patterns in strings using
% strfind.
idx = strfind(t,'in');  % indices of where substring is in the string
