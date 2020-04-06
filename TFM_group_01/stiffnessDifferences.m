clear; close all;clc
%% User parameters

%resXY_high = ; %Resolution in um for the high stiffness gel(to be filled by student)
%resXY_low = ; %Resolution in um for the low stiffness gel (to be filled by student)

minCorr = 0.6;
minBeadInt = 60;
blkSize = 24;

filtKernelSize = 3;
filtSigma = 0.5;

%poisson = ; %Poisson ratio of the material (to be filled by student)

%young_high = ; %Young's modulus (in kPa) of the high stiffness gel (to be filled by student)
%young_low = ; %%Young's modulus (in kPa) of the low stiffness gel (to be filled by student)

%% Read the input images

%Define the names of the folders that contain the images
folderHigh = 'Cell_high_stiffness_4_5kPa';
folderLow = 'Cell_low_stiffness_1_4kPa';

%Define the root and name of the files
relaxedHigh = ['ex6\',folderHigh,'\relaxedBeads.tif'];
stressedHigh = ['ex6\',folderHigh,'\stressedBeads.tif'];
cellHigh = ['ex6\',folderHigh,'\cellImage.tif']; 

relaxedLow = ['ex6\',folderLow,'\relaxedBeads.tif'];
stressedLow = ['ex6\',folderLow,'\stressedBeads.tif'];
cellLow = ['ex6\',folderLow,'\cellImage.tif']; 

%Read the images and convert them to grayscale
im_relaxed_high = rgb2gray(imread(relaxedHigh));
im_stressed_high = rgb2gray(imread(stressedHigh));
im_cell_high=rgb2gray(imread(cellHigh));

im_relaxed_low = rgb2gray(imread(relaxedLow));
im_stressed_low = rgb2gray(imread(stressedLow));
im_cell_low = rgb2gray(imread(cellLow));

% Plot the bead images (overlapping)
displayBeadOverlapping(im_relaxed_high,im_stressed_high)
title(['Cell on a high stiffness ECM (',num2str(young_high),' kPa)'])

displayBeadOverlapping(im_relaxed_low,im_stressed_low)
title(['Cell on a low stiffness ECM (',num2str(young_low),' kPa)'])
%% Calculate the displacements
[ux_high,uy_high] = calcNbeadDisp(im_relaxed_high,im_stressed_high,blkSize,minCorr,minBeadInt);

[ux_low,uy_low] = calcNbeadDisp(im_relaxed_low,im_stressed_low,blkSize,minCorr,minBeadInt);

% Convert the units of the displacements from px to um
ux_high = ux_high*resXY_high;
uy_high = uy_high*resXY_high;
dispResXY_high = resXY_high*blkSize;

ux_low = ux_low*resXY_low;
uy_low = uy_low*resXY_low;
dispResXY_low = resXY_low*blkSize;

% Plot displacements
% displayDispField(ux_high,uy_high,dispResXY_high,0);
% displayDispField(ux_low,uy_low,dispResXY_low,0);


%% Filter the displacements
%Define the filter
fltr = fspecial('gaussian',[filtKernelSize filtKernelSize],filtSigma);

%Filter the images
uxFilt_high = imfilter(ux_high,fltr,'same');
uyFilt_high = imfilter(uy_high,fltr,'same');

uxFilt_low = imfilter(ux_low,fltr,'same');
uyFilt_low = imfilter(uy_low,fltr,'same');
% Plot fitered displacements
displayDispField(uxFilt_high,uyFilt_high,dispResXY_high,1);
displayDispArrow(uxFilt_high,uyFilt_high,dispResXY_high,1);
title(['Cell on a high stiffness ECM (',num2str(young_high),' kPa)'])

displayDispField(uxFilt_low,uyFilt_low,dispResXY_low,1);
displayDispArrow(uxFilt_low,uyFilt_low,dispResXY_low,1);
title(['Cell on a low stiffness ECM (',num2str(young_low),' kPa)'])
%% Retrieve the tractions
[tx_high,ty_high] = tractionRetrieval(uxFilt_high,uyFilt_high,young_high,poisson,dispResXY_high);
[tx_low,ty_low] = tractionRetrieval(uxFilt_low,uyFilt_low,young_low,poisson,dispResXY_low);

% Plot tractions
displayTracField(tx_high,ty_high,dispResXY_high);
displayTracArrow(tx_high,ty_high,dispResXY_high);
title(['Cell on a high stiffness ECM (',num2str(young_high),' kPa)'])

displayTracField(tx_low,ty_low,dispResXY_low);
displayTracArrow(tx_low,ty_low,dispResXY_low);
title(['Cell on a low stiffness ECM (',num2str(young_low),' kPa)'])

%Plot cell and tractionMag
% im_cell_high = cropIm(im_cell_high,blkSize);
% im_cell_low = cropIm(im_cell_low,blkSize);

displayCellTrac(tx_high,ty_high,dispResXY_high,im_cell_high,blkSize);
title(['Cell on a high stiffness ECM (',num2str(young_high),' kPa)'])
displayCellTrac(tx_low,ty_low,dispResXY_low,im_cell_low,blkSize);
title(['Cell on a low stiffness ECM (',num2str(young_low),' kPa)'])
%% Calculate the total force for each case

%Calculate the magnitude of the tractions:
mag_trac_high = sqrt(tx_high.^2 + ty_high.^2);
mag_trac_low = sqrt(tx_low.^2 + ty_low.^2);

%Calculate the total traction:
tot_trac_high = sum(mag_trac_high(:));
tot_trac_low = sum(mag_trac_low(:));

%Calculate the total area of one block
area_high = blkSize^2 * resXY_high^2;
area_low = blkSize^2 * resXY_low^2;

%Calculate the total force:
tot_force_high = tot_trac_high * area_high;
tot_force_low = tot_trac_low * area_low;

