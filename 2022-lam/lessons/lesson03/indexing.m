%% Lesson 3: Advanced Indexing
%
% Objectives:
% - Review basic vector indexing
% - Introduce multidimensional indexing and linear indexing
% - Introduce logical indexing
clear; clc; close all;

%% Review of basic vector indexing
% Indexed expressions can appear on the right-hand side of an assignment 
% or the left-hand side (rvalues and lvalues in C).
x = [2 4 8 16 32 64 128];
x(3);
x(4:6);
x(:);
x(end);
x(2) = -4;

%% Vectors indexing vectors
% You can use a vector to index another vector. This can be useful if there
% is a specific index pattern you want from a vector.

x([1 3 5 7]);           % Returns a vector with the 1st, 3rd, 5th, and 7th
                        % entries of x
x(1:2:7);               % Same thing uses the colon operator to create the
                        % index vector
x([2:4 3:6]);
x([1:4]) = 7;           % Changes the values from the 1st and 4th entries
                        % of x to 7

%% Indexing matrices with 2 subscripts
% You can index a matrix using two indices, separated by a comma.
A = [16 2 3 13; 5 11 10 8; 9 7 6 12; 4 14 15 1];

A(1,1);                 % Returns entry in first row and first column
A(1:3,1:2);             % Returns the entries in the first three rows AND
                        % first two columns
A(end,:);

% What if I want to index the (2,1), (3,2), (4,4) entries?

A([2 3 4],[1 2 4]);     % Will this work?

%% Linear Indexing
% Instead you should index linearly! Linear indexing only uses one
% subscript

A(:);                   % What does this return and in what form and order?

reshape(A, [], 1);      % What about this?

A(14);                  % What value does this return?


%% Non-rectangular indices
% Now that we know about linear indexing, what values does this return?
A([2 7 16]);

% Luckily enough, MATLAB has a function that would calculate the linear
% index for you!
ind = sub2ind(size(A),[2 3 4],[1 2 4]);
A(ind);

% Note that sub2ind follows a common naming convention in MATLAB for
% converting one type to another. For example, there is also ind2sub,
% str2int, int2str, zp2tf, tf2zp, etc.

%% Logical Indexing
% Logical indexing allows us to use boolean logic to build more complex
% indices. This is based off of boolean logic: we have two boolean values
% TRUE (represented by 1) and FALSE (represented by 0), and the boolean
% operators AND, OR, and NOT.
% 
% Logical scalar and matrix literals can be constructed from double and
% matrix literals using the logical() function, or they may be generated
% from other operations. (Note that logical and double values have
% different data types.)

B = eye(4);               % Regular identity matrix
C = logical([1 1 1 1; 1 0 0 0; 1 0 0 0; 1 0 0 0]); % Logical entries
islogical(B);

islogical(C);

%% Some logical operators
B = logical(B);           % Converts B into a logical array

B & C;                    % and(B,C) is equivalent to B&C
B | C;                    % or(B,C) is equivalent to B|C
~(B & C);                 % not(and(B,C)) is equivalent to ~(B&C)
not(B & C);               % you can use both representations intermittenly

%% Functions that generate logical values
% The following functions are analogous to the ones() and zeros() functions
% for double matrices.
true(2,5);                % creates a 2x5 logical matrix of trues(1s)
false(2,5);

%% Generating logical values from predicates
% Relational (comparison) operators generate logical values. Relational
% operators on matrices will perform the operation element-wise and return
% a logical matrix.
%
% This is not anything really special, since we've seen element-wise
% operations on matrices. The only change is that instead of functions 
% that return numbers, we have functions that return booleans (predicates).
D = [1 2 3; 2 3 4; 3 4 5];
E = [1 5 6; 9 2 8; 7 3 4];

D == 3;                     % Returns true every place there is a 3.

D < E;                      % Elementwise comparison
D < 3;                      % Elementwise comparison against a scalar.
                            % (Note: this is broadcasting!)
D < [7; 4; 1];              % Another example of broadcasting: comparison
                            % of each row against a scalar.

%% Logical indexing
% Logical indexing uses a logical value as the index. Elements in the 
% indexed matrix where the logical index is TRUE will be returned, and 
% FALSE values will be disregarded. The returned matrix will always be 
% a column vector, similar to indexing with (:).
A(A > 12);                  % returns entries of A which are greater 
                            % than 12 in a column vector

% To return the linear indices of the TRUE values in a logical matrix.
find(A > 12);
A(find(A > 12));            % Gives the same results as above
