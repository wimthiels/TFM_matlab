clear; close all; clc;

%% Read the images

%Load the bead image
im_beads = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex7/im_beads.tif');

%Load the cell image
%TO DO
im_cell = imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex7/cell4.tif')

% Plot both images (overlapping)
displayTwoOverlapping(im_beads,im_cell)

%% Cell segmentation

%Filter noise if needed
im_cell_2 = imdiffusefilt(im_cell)

%Binarize image
[counts,x] = imhist(im_cell_2,16);
T = otsuthresh(counts)
BW = imbinarize(im_cell_2,T);

%Morphological operations
BW2 = imfill(BW,'holes');

%Plot results step by step
figure

subplot(221)
imshow(im_cell,[])
title('Original');

subplot(222)
imshow(im_cell_2,[])
title('Filtered');

subplot(223)
imshow(BW,[])
title('Binarized');

subplot(224)
imshow(BW2,[])
title('Morphological operations');

%% Bead removal
im_beads_no_cell = im_beads
im_beads_no_cell(BW2==1)=0

% Plot both images (overlapping)
displayTwoOverlapping(im_beads,im_beads_no_cell)