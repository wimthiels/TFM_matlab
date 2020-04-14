clear;close all;clc;
%% User parameters

%Define image resolution (pixel size)
resXY = 0.15; % units in um/pixel

%Define displacement calculation parameters
minCorr = 0.6;
blkSize = 32; % units in pixels

%Define filtering parameters
filtKernelSize = 3; % units in pixels
filtSigma = 1;

%Define material properties
poisson = 0.34;
young = 1.5; % units in kPa

%Define the paths for the two images
im1File = 'ex5\relaxedIm_multibeadsTest.tif';
im2File = 'ex5\stressedIm_multibeadsTest.tif';
%% Read the input images

%Load images
im1 = imread(im1File);
im2 = imread(im2File);

%Calculate the min bead intenstiy
minBeadInt = calcMinBeadInt(im1);

% Plot the bead images (overlapping)
displayBeadOverlapping(im1,im2)
%% Calculate the displacements

%Compute displacements in pixels
[ux,uy] = calcNbeadDisp(im1,im2,blkSize,minCorr,minBeadInt);

% Convert the units of the displacements from px to um
ux = ux*resXY;
uy = uy*resXY;
dispResXY = resXY*blkSize;

% Plot displacements
displayDispField(ux,uy,dispResXY,0);
%% Filter the displacements

%Define a filter
fltr = fspecial('gaussian',[filtKernelSize filtKernelSize],filtSigma);

%Filter both components of the displacement field
uxFilt = imfilter(ux,fltr,'same');
uyFilt = imfilter(uy,fltr,'same');

% Plot filtered displacements
displayDispField(uxFilt,uyFilt,dispResXY,1);
displayDispArrow(uxFilt,uyFilt,dispResXY,1);

%% Retrieve the tractions
[tx,ty] = tractionRetrieval(uxFilt,uyFilt,young,poisson,dispResXY);

% Plot tractions
displayTracField(tx,ty,dispResXY);
displayTracArrow(tx,ty,dispResXY);