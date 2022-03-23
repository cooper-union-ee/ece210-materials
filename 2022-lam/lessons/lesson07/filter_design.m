%% Lesson 7c. Designing filters.
% * Learn how to use the `filterDesigner` GUI.
% * Learn how to manually design a filter.
clc; clear; close all;

%% Filter Overview
% Remember order = # of delay elements, want to minimize to meet
% some spec.
%
% There are 4 main types of filters:
% * Lowpass - passes low frequencies through
% * Highpass - passes high frequencies through
% * Bandpass - passes a specific band
% * Bandstop - stops a specific band from going through
%
% There are four primary implementations of filters that optimize
% different properties:
% * Butterworth - maxflat passband, monotonic passband & stopband
% * Chebychev I - equiripple passband, monotonic stopband
% * Chebychev II - monotonic passband, equiripple stopband
% * Elliptic - minimum order, equiripple passband & stopband
%
% In this lesson, you will be able to very clearly see these
% properties and filter types!

%% Filter Design (GUI)
% Note: Ask Prof. Keene about `filterDesigner`, it'll make him
% very happy.
filterDesigner;         % then export to workspace as numerator and
                        % denominator (not SOS for now)

%% Filter Design (Code)
% Manually specify specifications
Fs = 44100;
Apass = 1;
Astop = 80;
Fpass = 1e3;
Fstop = 1e4;
wpass = Fpass / (Fs/2); % normalized to nyquist freq.
wstop = Fstop / (Fs/2); % normalized to nyquist freq.

% Compute the minimum order for Butterworth filter
% that meets the specifications.
% Alternatively, see `butter1ord`, `cheby1ord`,
% `cheby2ord`, `ellipord`.
n = buttord(wpass, wstop, Apass, Astop);

% Generate Butterworth filter with order `n` (which is 
% designed to meet the specification).
% Alternatively, see `cheby1`, `cheby2`, `ellip`.
[b, a] = butter(n, wpass);
[H, W] = freqz(b, a);

% Plot the frequency response. (At this point, recall that
% the frequency response is the FFT of the impulse response.
% Can you generate the frequency response without using
% the `freqz` function (instead using the `impz` and `fft`
% functions)?
f = W .* Fs/(2*pi);
figure;
semilogx(f, 20*log10(abs(H)));
xlim([1e2 1e5]);
ylim([-100 5]);
grid on;
title 'Butterworth Lowpass Filter';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude (dB)';

%% Applying a filter
% Note that if a filter is generated using a `filterDesigner` function,
% it will be a filter object. You can apply a filter object using the
% `filter()` function. If your filter is given as an impulse response, you
% can either use the `filter()` function or convolve the impulse response
% and the input signal.

% Load handel again
load handel;

% Get a generated filter (this should decimate a narrow frequency band
% centered at 2.5kHz, assuming a 8192Hz sampling frequency).
flt = bandstop2500;

% Perform the filter
y1 = filter(flt, y);

%% How does it sound now?
sound(y1, Fs);

%% Plotting the result
% Obtain the FFT of the filtered signal.
N = 2^15;
S = fft(y1, N);
S = fftshift(abs(S)) / N;
F = linspace(-Fs/2, Fs/2, N);

% Plot the FFT.
figure;
plot(F, S);
title 'Fourier Transform of Audio';
xlabel 'Frequency (Hz)';
ylabel 'Magnitude';
