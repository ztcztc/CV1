close all
run('vlfeat/toolbox/vl_setup')

boat1 = single(imread('boat1.pgm'));
boat2 = single(imread('boat2.pgm'));


matches_50 = keypoint_matching(boat1,boat2);


% Iterations of RANSAC
N = 100;
% Amount of matches to sample
P = 100;



tp = RANSAC(N, P, matches_50);
% tp = [1.0986 -0.2747  0.2727 1.0932 25.1593 -145.8070]';

T = [tp(1,1) tp(2,1) tp(5,1);tp(3,1) tp(4,1) tp(6,1);0 0 1];
T2 = T;
T2(1:2,3) = 0;
imgA = im2double(imread('boat1.pgm'));
imgB = im2double(imread('boat2.pgm'));
Tm = affine2d(T2');
wrapped = wrap(imgB,T,'non');
wrapped2 = imwarp(imgB,Tm);

figure;
imshow(wrapped)
figure;
imshow(wrapped2)
%rotated image
%figure
%imshow(boat1);
%imshow(aligned_image)
%imshow([boat1,aligned_image], [min(min(aligned_image)),max(max(aligned_image))]);

