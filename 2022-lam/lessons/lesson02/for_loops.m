%% Lesson 2b: Control Sequence - For loops
% Similar to other languages, MATLAB have if, while and for control
% sequences. For loops are one of the commonly used control sequences in
% MATLAB. We will continue the discussion of if and while in the next
% lesson.

clear;
n = 1e7;
% D = zeros(1,n);   % This is called pre-allocation
                    % try uncommenting this line to see the
                    % difference. Memory allocations are slow!

% Calculate fib(n). Hard to do vectorized unless we know Binet's formula.
% (Note that this will quickly overflow, but that's not our objective
% here.)
D(1) = 1;
D(2) = 2;
tic                 % start timer
for i = 3:n
    D(i) = D(i-1) + D(i-2);
end
toc                 % print elapsed time since last tic

%% Be careful!
% For loops are considered the more inefficient type of operation in
% MATLAB. Performing operations on vectors is faster because your hardware
% can optimize vectorized instructions, and because the "for" construct
% exists in MATLAB's runtime, which is essentially a scripting language and
% thus is slow.
%
% However, things are changing, and things like parfor (parallel-for) and
% advanced JIT (just-in-time) compilation are improving the performance of
% loops. But vectorized operations are almost always faster and should
% be used where possible.