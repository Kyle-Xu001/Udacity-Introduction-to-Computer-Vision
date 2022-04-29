%% Explore Edge Options
img = imread('car1.jpg');

% Create a Gaussian Filter
filter_size = 51;
filter_sigma = 1000;
filter = fspecial('gaussian', filter_size, filter_sigma);

% Apply the Guassian Filter with edge parameter
smoothed1 = imfilter(img, filter, 0);
smoothed2 = imfilter(img, filter, 'circular');
smoothed3 = imfilter(img, filter, 'replicate');
smoothed4 = imfilter(img, filter, 'symmetric');

% Result Visualization
figure(1)
subplot(2,2,1)
imshow(smoothed1)
title('a) Method: Clip Back(Black)')
subplot(2,2,2)
imshow(smoothed2)
title('b) Method: Warp Around')
subplot(2,2,3)
imshow(smoothed3)
title('c) Method: Copy Edge')
subplot(2,2,4)
imshow(smoothed4)
title('d) Method: Reflect Edge')

sgtitle('Figure 1: Edge Options Exploration')

%% Median Filter
figure(2)
% Add noise to the image
noisy_img = imnoise(img(:,:,1), 'salt & pepper', 0.02);

% Apply a median filter
median_filtered = medfilt2(noisy_img,[3,3]);

% Result Visualization
subplot(1,2,1)
imshow(noisy_img)
title('a) Salt & Pepper Noise')
subplot(1,2,2)
imshow(median_filtered)
title('b) Median Filter Application')

%% Normalized Correlation
s = [-1 0 0 1 1 1 0 -1 -1 0 1 0 0 -1];
t = [1 1 0];
disp('Signal:'), disp([1:size(s, 2); s]);
disp('Template:'), disp([1:size(t, 2); t]);

s_size = length(s);
corr  = [];
for i = 1:s_size-2
    corr = [corr,s(i)*t(1) + s(i+1)*t(2) + s(i+2)*t(3)];
end
disp(corr)

normxcorr2(t,s)