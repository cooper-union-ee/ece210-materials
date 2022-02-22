%% Lesson 5c: Character Arrays and Strings

clear
myString = 'Hello World!';
whos

%%
stem(uint16(myString))
title([myString '''s' ' Numeric Code'])

%% sprintf
% The sprintf function is useful in formatting strings to be output like
% you would in C.

numberOfStudents = 20;
section = 'B';
averageGrade = mean(40 + randn(numberOfStudents,1));
sprintf('There are %d students in physics section %s with an average grade of %0.2f',...
        numberOfStudents,section,averageGrade)

%%
numberOfStudents = 41;
averageGrade = mean([-inf; 80 + randn(numberOfStudents,1)]);
sprintf('There are %04d students in signals with an average grade of...\n %0.2f',...
        numberOfStudents,averageGrade)
    
%%
plotTitles = ['Hello World!';...
              'This will never ';...
              'work!'];
          
%% String Arrays

plotLegends = [string('Hello World!');...
string('This will indeed ');...
string('work')]

%%
% or better

plotLegends = ["Hello World!";...
"This will indeed ";...
"work"]

%%
plot(rand(10,3))
legend(plotLegends)

%%
plotLegends(3)
plotLegends{3}(4)

% Why does the above work? Per the docs, "You can index into a string array
% using curly braces, {}, to access characters directly. Use curly braces
% when you need to access and modify characters within a string element.
% Indexing with curly braces provides compatibility for code that could
% work with either string arrays or cell arrays of character vectors. But
% whenever possible, use string functions to work with the characters in
% strings."

%% Parsing
% Using split, you can separate strings into a cell array or string array
% based on certain qualifications, most commonly whitespace.

t = ['The rain in Spain stays' newline 'mainly in the plain.']

split(t)
split(t,'n')

% You can also return the delimiters if you want
[cellArray, delimiters] = split(t,{'n' 'h'})

% You can also use the function strsplit, but it's not recommended
strsplit(t)

%% Finding Substrings
% In a similar fashion, you can search for patterns in strings using
% strfind.

idx = strfind(t,'in')          % indices of where substring is in the string
