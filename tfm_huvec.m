

clear 
close all
clc

%% User parameters

resXY = 0.33;
minCorr = 0.6;
minBeadInt = 60;
blkSize = 32;

filtKernelSize =3;
filtSigma = 0.7;

poisson = 0.34;
young = 1.5;


im1File = 'ex6\relaxedIm_realCell.tif';
im2File = 'ex6\stressedIm_realCell.tif';
imCell = 'ex6\realCell.tif'; 


%% Read the input images
im1 = imread(im1File);
im2 = imread(im2File);

% Plot the bead images (overlapping)
displayBeadOverlapping(im1,im2)

%% Calculate the displacements

[ux,uy] = calcNbeadDisp(im1,im2,blkSize,minCorr,minBeadInt);
% Convert the units of the displacements from px to um
ux = ux*resXY;
uy = uy*resXY;
dispResXY = resXY*blkSize;
% Plot displacements
displayDispField(ux,uy,dispResXY,0);



%% Filter the displacements
fltr = fspecial('gaussian',[filtKernelSize filtKernelSize],filtSigma);
uxFilt = imfilter(ux,fltr,'same');
uyFilt = imfilter(uy,fltr,'same');
% Plot filtered displacements
displayDispField(uxFilt,uyFilt,dispResXY,1);
displayDispArrow(uxFilt,uyFilt,dispResXY,1)



%% Retrieve the tractions
[tx,ty] = tractionRetrieval(uxFilt,uyFilt,young,poisson,dispResXY);
% Plot tractions
displayTracField(tx,ty,dispResXY);
displayTracArrow(tx,ty,dispResXY);
%Plot cell and tractionMag
cellIm = imread(imCell);
displayCellTrac(tx,ty,dispResXY,cellIm,blkSize);






