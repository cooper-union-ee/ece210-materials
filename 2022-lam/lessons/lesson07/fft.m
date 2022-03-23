% Lesson 7a. The FFT
clear; clc; close all;

%%
load handel;
audiowrite('handel.wav', y, Fs);
[y, Fs] = audioread('handel.wav');  % Fs = sample freq.
sound(y, Fs);
T = 1/Fs;
t = 0:T:(length(y)-1)*T;

%% loud noise warning!!!
Fnoise = 2500;
noise = 0.2*sin(2*pi*t*Fnoise).';  % additive "noise" with freq. 2.5kHz
y = noise + y;
% sound(y, Fs);

%%
N= 2^15;
S = fft(y, N);                       % N point dft (best to use power of 2)
S = fftshift(abs(S)) / N;

% fftshift is necessary since MATLAB returns from fft the zeroth frequency
% at the first index, then the positive frequencies, then the negative
% frequencies when what you probably want is the zeroth frequency centered
% between the negative and positive frequencies.

F = Fs .* (-N/2:N/2-1) / N;

% Each frequency index represents a "bin" of frequencies between -Fs/2 and
% Fs/2 (so index i represents i*Fs/N).

figure;
plot(F, S);
title 'Fourier Transform of Audio';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';


%% Alternative way to generate FFT plots:
% slightly-less accurate but more readable version of F
wd = linspace(-pi, pi, N+1);
wd = wd(1:end-1);
F2 = wd * Fs / (2 * pi);

% Some arbitrariness in scaling factor. It's more important that
% you use the same scaling when performing FFT as IFFT. See
% https://www.mathworks.com/matlabcentral/answers/15770-scaling-the-fft-and-the-ifft#answer_21372
% (use the formula Prof. Fontaine wants you to use.)
S = fftshift(fft(y)) / Fs;

% this S is complex; you can take either abs() or angle() of it to get
% magnitude and phase responses, respectively