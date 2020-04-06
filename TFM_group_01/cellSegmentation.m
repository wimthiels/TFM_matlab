clear; close all; clc;

%% Read the images

%Load the bead image
im_beads = imread('ex7\im_beads.tif');

%Load the cell image
%TO DO
%im_cell = imread('ex7\cell...

% Plot both images (overlapping)
displayTwoOverlapping(im_beads,im_cell)

%% Cell segmentation

%Filter noise if needed
%TO DO

%Binarize image
%TO DO

%Morphological operations
%TO DO

%Plot results step by step
% TO DO

% figure

% subplot(221)
% imshow(im_cell,[])
% title('Original');

% subplot(222)
% ...
% title('Filtered');

% subplot(223)
% ...
% title('Binarized');

% subplot(224)
% ...
% title('Morphological operations');

%% Bead removal

%TO DO

% Plot both images (overlapping)
displayTwoOverlapping(im_beads,im_beads_no_cell)