% Lesson 7c. Designing filters.
clc; clear; close all;

%% Filter Overview
% Remember order = # of delay elements, want to minimize
% There are 4 main types of filters:
%   Lowpass - passes low frequencies through
%   Highpass - passes high frequencies through
%   Bandpass - passes a specific band
%   Bandstop - stops a specific band from going through
%
% There are primarily 4 implementations of filters
%   Butterworth - maxflat passband, monotonic passband & stopband
%   Chebychev I - equiripple passband, monotonic stopband
%   Chebychev II - monotonic passband, equiripple stopband
%   Elliptic - minimum order, equiripple passband & stopband

%% Filter Design (GUI)
% Note: Ask Prof. Keene about `filterDesigner`, it'll make him
% very happy.
filterDesigner;         % then export to workspace as numerator and
                        % denominator (not SOS for now)

%%
flt = bandstop2500();

y1 = filter(flt, y);
% sound(y1, Fs)

S1 = fft(y1, N);
S1 = fftshift(abs(S1)) / N;

figure;
plot(F, S1);
title 'Fourier Transform of Audio';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';

%% Filter Design (Code)
Fs = 44100;
Apass = 1;
Astop = 80;
Fpass = 1e3;
Fstop = 1e4;
wpass = Fpass/(Fs/2); %normalized to nyquist freq.
wstop = Fstop/(Fs/2); %normalized to nyquist freq.

%%

% Compute the minimum order for Butterworth filter
% that meets the specifications.
n = buttord(wpass, wstop, Apass, Astop);
[b,a] = butter(n, wpass);
[H,W] = freqz(b, a);

% Convert frequency from digital to analog
f = W .* Fs/(2*pi);
figure;
semilogx(f, 20*log10(abs(H)));
xlim([1e2 1e5]);
ylim([-100 5]);
grid on;
title 'Butterworth Lowpass Filter';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude (dB)';