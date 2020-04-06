clear; close all; clc;

% Read the relaxed image
im_relaxed = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex1/im_bead_relaxed.tif');

%Read the stressed image
im_stressed = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex1/im_bead_stressed_X_3.14_Y_-6.18.tif')


% Plot the bead images (overlapping)
displayBeadOverlapping(im_relaxed,im_stressed)

% Calculate the displacements
[s,corrVal] = shiftCalc(im_relaxed,im_stressed);