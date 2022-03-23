%% Lesson 7b: The FFT -- for images!
% * Explore how to perform and plot the FFT of a 2-D signal
% * Implement a filter by masking in the frequency domain
clc; clear; close all;

%% Image Example
% Low pass filtering
% Here we look at images. Think frequencies spatially. High frequency
% represents fast change in the image, low frequency represents slight
% change. Also frequenies have two dimensions, vertial and horizontal.
x = imread('lena.tiff');
imshow(x);

%% 2-D FFT!
F = fftshift(fft2(x));

% Generate a mask (which will be a high-pass filter).
% This mask will be 1 for low frequencies, and 0 for high frequencies.
% Since the signal and its FFT are 2-D (an image), this will be a
% white square centered in the FFT.
lpf_mask = zeros(size(F));
[H, W] = size(F);
lpf_mask(floor(H/2-H/10):floor(H/2+H/10), ...
    floor(W/2-W/10):floor(W/2+W/10)) = 1;

% Show the 2-D FFT of the image
figure;
subplot(121);
% Normalize FFT to range [0, 1]
imshow(log(abs(F)) / max(log(abs(F(:)))));
title 'Fourier transform';

% Show the LPF mask
subplot(122);
imshow(lpf_mask);
title 'LPF mask';

%% Perform a LPF by only multiplying by frequency mask
im_filtered_fft = lpf_mask .* F;        % high frequencies removed
f = ifft2(ifftshift(im_filtered_fft));  % ifft2 == ifft 2-D
imshow(log(abs(im_filtered_fft)) / max(log(abs(im_filtered_fft(:)))));
title 'Filtered FFT';

%% Altered image vs. original image
% Check out how the new image looks a bit blurry. That's because we removed
% the high frequency band! All "edges" are less noticable.
%
% Alternatively, we can perform a high-pass filter. What would this do
% to the image? (Hint: see next section.)
figure;
subplot(121);
fnorm = abs(f) / max(abs(f(:)));
imshow(fnorm);
title 'High frequencies removed';

subplot(122);
xnorm = abs(double(x)) / max(double(x(:)));
imshow(xnorm);
title 'Original image';

%% Basic Edge Detection
% The difference between the old image and the new image: The edges!
sharp_image = abs(fnorm - xnorm);
sharp_image_norm = sharp_image / max(sharp_image(:));
imshow(sharp_image_norm);

%% Pinpoints these changes
edge_image = zeros(size(sharp_image_norm));
edge_image(sharp_image_norm > 3.5*std(sharp_image_norm(:))) = 1;
imshow(edge_image);

% Edge detection algorithms are one application of high-pass filters!
% If you want to get started with these, look up Sobel or Laplacian
% filters, which are simple convolutions that act as edge detectors/HPFs.
