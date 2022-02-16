%% Lesson 4b: Control Sequences
%
% Similar to C, MATLAB has control sequence commands. Last class we
% explored for loops and the difference between for loops and
% vectorization. Even though vectorization is more computationally 
% efficient than loops, sometimes for loops, and other control sequences,
% are necessary, such as to perform simulations. However, assuming that
% everyone has an understanding of control sequences, I would not delve
% too deep into the discussion of the mechanics of if and while statements,
% but rather, I would show you the semantics of the statements. 

%% For loops (A review)

total=0;
for i=1:10
    total = total + i;
end
total

%% If...Else Statements

vgpa = 1.76;
wgpa = 2.52;
xgpa = 3.55;
ygpa = 3.76;
zgpa = 3.83;
gpa = vgpa;
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

total=0;
i=0;
while i<=10
    total = total + i;
    i = i+1;
end
total

%% Try and Catch blocks
%
% Try and catch blocks are particularly useful if you don't know whether a 
% certain statement would occur and the new code depends on that certain 
% line of code. Try and catch allows you to "catch" errors and display 
% error statements.

try
    a = [1 2; 3 4];
    b = [1 2 3 4];
    c = a*b          % Can't do this! not the same dimensions!
catch err
    fprintf('You are trying to do something which is not allowed');
    % you can check documation for more things you you can do and
    % information you can get from the error
end