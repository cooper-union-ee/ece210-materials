%% Lesson 7a. The FFT
% * Explore how to perform the FFT (DFT) on a 1-D signal
% * Learn how to plot the FFT
clear; clc; close all;

%% Load a sample signal
load handel;    % builtin dataset that loads `y` and `Fs` to your workspace
sound(y, Fs);
T = 1/Fs;
t = 0:T:(length(y)-1)*T;

%% Loud noise warning!!!
Fnoise = 2500;
noise = 0.2*sin(2*pi*t*Fnoise).';    % additive "noise" with freq. 2.5kHz
y = noise + y;
% sound(y, Fs);

%% Perform the FFT
% Recall that the Fast Fourier Transform is a well-known and efficient
% implementation of the DFT. The DFT is a Fourier transform on a
% N-point fixed-length signal, and produces a N-point frequency spectrum.
N = 2^15;
S = fft(y, N);                       % N-point DFT (best to use power of 2)

% Note the behavior of doing `fft(y, N)` (taken from the documentation):
% * If X is a vector and the length of X is less than n, then X is padded 
%   with trailing zeros to length n.
% * If X is a vector and the length of X is greater than n, then X is 
%   truncated to length n.
% * If X is a matrix, then each column is treated as in the vector case.
% * If X is a multidimensional array, then the first array dimension 
%   whose size does not equal 1 is treated as in the vector case.
%
% This is the time when padding with zeros is acceptable (when performing
% a FFT where N > length(y))!

S = fftshift(abs(S)) / N;
% fftshift is necessary since MATLAB returns from DFT the zeroth frequency
% at the first index, then the positive frequencies, then the negative
% frequencies when what you probably want is the zeroth frequency centered
% between the negative and positive frequencies.

% Get (analog) frequency domain. E.g., if you perform a 128-pt
% FFT and sampled at 50kHz, you want to generate a 128-pt frequency range
% from -25kHz to 25kHz.
F = Fs .* (-N/2:N/2-1) / N;
% Each frequency index represents a "bin" of frequencies between -Fs/2 and
% Fs/2 (so index i represents i*Fs/N).

figure;
plot(F, S);
title 'Fourier Transform of Audio';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';

%% Alternative ways to generate FFT plots:
% Slightly more readable version of frequency domain.
% Get the digital frequency 
wd = linspace(-pi, pi, N+1);
wd = wd(1:end-1);
F2 = wd * Fs / (2 * pi);

% Equivalent formulation, without going through the digital domain.
F3 = linspace(-Fs/2, Fs/2, N+1);
F3 = F3(1:end-1);

% Slightly more readable but less accurate version.
F4 = linspace(-Fs/2, Fs/2, N);

% Some arbitrariness in scaling factor. It's more important that
% you use the same scaling when performing FFT as IFFT. See
% https://www.mathworks.com/matlabcentral/answers/15770-scaling-the-fft-and-the-ifft#answer_21372
% (use the formula Prof. Fontaine wants you to use.)
S = fftshift(fft(y, N)) / Fs;

% This S is complex; you can take either abs() or angle() of it to get
% magnitude and phase responses, respectively
figure;
plot(F2, abs(S));
% plot(F3, abs(S));
% plot(F4, abs(S));
title 'Fourier Transform of Audio';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
