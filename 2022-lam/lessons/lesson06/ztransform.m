%% Lesson 6b
% * Have a overview idea of the z transform
% * Know how to plot pole zero plots of the z transform, and what to infer
% * Know how to input a signal to the transfer function of z transform
clc; clear; close all;

%% Review
% Plot all discrete-time signals with `stem()`! Don't use `plot()`.
x = [2 4 7 2 0 8 5];
stem(x);
title("Discrete Time signal");

%% Overview of the z transform
% The z transform converts a discrete time signal into a complex frequency
% domain representation (a series of complex exponentials).
% There are two key motivations of the z transform:
%
% * By identifying the impulse response of the system we can determine how
% it would perform in different frequencies
% * By identifying the presence of increasing or decreasing oscillations in
% the impulse response of a system we can determine whether the system
% could be stable or not

%% Z transform
% One of the things we usually evaluate in the z transform is the pole zero
% plot, since it can tell us about stability and causality in
% different regions of convergence. Let us just look at one simple example
% of a pole zero plot.

%% Z transform - generate a pole zero plot
% There are multiple ways to generate the pole zero plot. If you are
% interested, you should look up tf2zp (and its inverse, zp2tf), pzplot,
% etc. We are going to introduce the most simple function -- zplane. In the
% example, b1 and a1 and coefficients of the numerator and denominator,
% i.e, the transfer function. The transfer function is the
% the ratio between output (denominator) and input (numerator).

b1 = [1];       % numerator
a1 = [1 -0.5];  % denominator
figure;
zplane(b1, a1);

%% BE CAREFUL!
% If the input vectors are COLUMN vectors, they would be interpreted as
% poles and zeros, and if they are ROW vectors, they would be interpreted
% as coefficients of the transfer function.

%% BE CAREFUL!
% zplane takes negative power coefficients, while tf2zp (the one used
% in the homework) uses positive power coefficients.

% In particular, note that polynomials with negative power efficients are
% LEFT-ALIGNED, while polynomials with positive power coefficients are
% RIGHT-ALIGNED. E.g., for positive coefficients b1 and [0 b1] are the
% same polynomial, but not so if negative coefficients. See the following
% example.

% $1/(1-0.5z^-1) = z/(z-0.5)$
figure;
zplane(b1, a1);

% $(0+z^-1)/(1-z^-1) = 1/(z-0.5)$
figure;
zplane([0 b1], a1);

%% tf2zp and zp2tf
b = [2 3 0];
a = [1 1/sqrt(2) 1/4];

[z, p, k] = tf2zp(b, a);
% alternatively, tf2zpk

figure;
zplane(z, p);
[b, a] = zp2tf(z, p, k);

%% Z transform - More examples!

b2 = [1];
a2 = [1 -1.5];
b3 = [1 -1 0.25];
a3 = [1 -23/10 1.2];

% Example 1 : One pole, outer region is stable and causal
figure;
subplot(3, 1, 1);
zplane(b1, a1);
title('$$H_1(z)=\frac{z}{z-\frac{1}{2}}$$', 'interpreter', 'latex');

% Example 2 : One pole, outer region is causal but not stable, inner region
% is stable but not causal
subplot(3, 1, 2);
zplane(b2,a2);
title('$$H_2(z)=\frac{z}{z-\frac{3}{2}}$$', 'interpreter', 'latex');

% Example 3 : Two poles, outer region is causal, middle region is stable
subplot(3, 1, 3);
zplane(b3, a3);
title('$$H_3(z)=\frac{(z-\frac{1}{2})^2}{(z-\frac{4}{5})(z-\frac{3}{2})}$$', ...
    'interpreter', 'latex');

%% On Stability and Causality
% * The system is stable iff the region contains the unit circle.
% * The system is causal iff the region contains infinity.
% * If there is an infinity to the pole, then it's not stable.
% * If all the poles are in the unit circle, then the system could be both
% stable and causal.

%% Z transform - Impulse Response
% The impulse response is useful because its Fourier transform 
% (the frequency response) allows us to observe how an input sinusoid
% at different frequencies will be transformed.
%
% The impulse response is obtained by applying the filter to a delta.
% There is a custom function to do this (`impz`), but you can also obtain
% it other ways.
% 
% The impulse response for the running example is the following (can you
% derive this by hand?)
% $h[n] = (1/2)^n$
[h1, t] = impz(b1, a1, 8);   % h is the IMPULSE RESPONSE
figure;
impz(b1, a1, 32);            % for visualization don't get the return value

%% Z transform - Convolution
% You can apply a system on a signal in two ways:
% * Convolve with the impulse response (which we obtained just now).
% * Use the `filter` functions (which uses tf coefficients).
n = 0:1:5;
x1 = (1/2).^n;
y1 = conv(x1, h1);

figure;
subplot(2, 1, 1);
stem(y1);
title('Convolution between x_1 and h_1');
subplot(2, 1, 2);
y2 = filter(b1, a1, x1);
stem(y2);
title('Filter with b_1,a_1 and x_1');
xlim([0 14]);
% The above are the same! Except note that convolution creates a longer
% "tail."

%% freqz: digital frequency response
% The frequency response is the z-transform of the impulse response. It
% tells us how the system will act on each frequency of the input signal
% (scaling and phase-shifting).
%
% This is a somewhat complicated setup -- you may want to save it to a
% function if you have to do this repeatedly.
[H, w] = freqz(b1, a1);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

% Note the above, especially the `unwrap` function! Make sure to understand
% what each of the functions above is for.

figure;
subplot(2, 1, 1);
plot(w, Hdb);
xlabel("Frequency (rad)");
ylabel("|H| (dB)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Magnitude Response");

subplot(2, 1, 2);
plot(w, Hph);
xlabel("Frequency (rad)");
ylabel("Phase (deg)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Phase Response");

%% Another example of freqz
% By default, `freqz` knows nothing about the sampling rate, so the
% frequency scale is digital. We can make it in analog frequency by
% specifying the sampling rate of the digital signal.

n = 1024;     % number of samples in frequency response
fs = 20000;   % sampling frequency of input signal
[H, f] = freqz(b1, a1, n, fs);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2, 1, 1);
plot(f, Hdb);
xlabel("Frequency (Hz)");
ylabel("|H| (dB)")
xlim([0 fs/2]);
title("Magnitude Response");

subplot(2, 1, 2);
plot(f, Hph);
xlabel("Frequency (Hz)");
ylabel("Phase (deg)");
xlim([0 fs/2]);
title("Phase Response");

%% Yet another example of freqz
zer = -0.5;
pol = 0.9*exp(j*2*pi*[-0.3 0.3]');

figure;
zplane(zer, pol);

[b4,a4] = zp2tf(zer, pol, 1);

[H,w] = freqz(b4, a4);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2, 1, 1);
plot(w, Hdb);
xlabel("Frequency (rad)");
ylabel("|H| (dB)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Magnitude Response");

subplot(2, 1, 2);
plot(w, Hph);
xlabel("Frequency (rad)");
ylabel("Phase (deg)");
xlim([0 pi]);
xticks([0 pi/2 pi]);
xticklabels({'0', '\pi/2', '\pi'});
title("Phase Response");

%% freqs
% Used for an analog filter. We won't use this here, since we're mostly
% concerned with digital signal processing.
a = [1 0.4 1];
b = [0.2 0.3 1];

w = logspace(-1, 1);
H = freqs(b, a, w);

Hdb = 20*log10(abs(H));
Hph = rad2deg(unwrap(angle(H)));

figure;
subplot(2, 1, 1);
semilogx(w, Hdb);
xlabel("Frequency (rad/s)");
ylabel("|H| (dB)");
title("Magnitude Response");

subplot(2, 1, 2);
semilogx(w, Hph);
xlabel("Frequency (rad/s)");
ylabel("Phase (deg)");
title("Phase Response");
