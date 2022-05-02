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
clc;clear;

s = [-1 0 0 1 1 1 0 -1 -1 0 1 0 0 -1];
t = [1 1 0];
disp('Signal:'), disp([1:size(s, 2); s]);
disp('Template:'), disp([1:size(t, 2); t]);

% Direct Method
corr = normxcorr2(t,s);
[max_value, max_index] = max(corr);
index = max_index - size(t,2) +1;
disp('Index:'), disp(index);

% Manually Calculation
corr = [];
for i = 1:size(s,2)-2
    s_ = (s(i)+s(i+1)+s(i+2))/3;
    s1 = s(i) - s_;
    s2 = s(i+1) - s_;
    s3 = s(i+2) - s_;
    coeff = (s1*t(1) + s2*t(2) + s3*t(3))/sqrt(2/3*(s1^2+s2^2+s3^2));
    corr(end+1) = coeff;
end
[max_value, max_index] = max(corr);
index = max_index;
disp('Index:'), disp(index);