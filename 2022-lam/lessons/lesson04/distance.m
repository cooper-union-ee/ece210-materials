% In a file like this one (which only defines normal functions,
% and in which the first function is hononymous with the filename), 
% the first function is a public function, and all other functions
% are local helper functions.
%
% Note that you DO NOT want to put clc; clear; close all; at the top of
% a file like this; it only makes sense to do this at the top of script
% files when you want to clean your workspace!

% Calculate Euclidean distance
% A public function, callable by other files and from the Command Window
% if this is in the MATLAB path
function d = distance(x, y)
    d = sqrt(sq(x) + sq(y));
end

% A local helper function. Only accessible within this file.
function x = sq(x)
    x = x * x;
end
