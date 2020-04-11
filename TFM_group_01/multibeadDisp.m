clear; close all; clc;
%% Read the images
im_relaxed = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex2/im_beads_relaxed.tif');
im_stressed = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex2/im_beads_stressed.tif');

% Plot the bead images (overlapping)
displayBeadOverlapping(im_relaxed,im_stressed)
%% Displacement calculation

%User parameters
blkSize = 16; 
minCorr = 0.6;

%Calculate the minimum bead intensity
minBeadInt = calcMinBeadInt(im_relaxed);

%Calculate displacements
[ux,uy] = calcNbeadDisp(im_relaxed,im_stressed,blkSize,minCorr,minBeadInt);


% Plot displacements
displayDispField(ux,uy,1,0);
displayDispArrow(ux,uy,1,0);