clear;close all;clc;
%% Read images 
beads_relaxed_high=imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex3/im_beads_relaxed_BD_1.tif');
beads_stressed_high=imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex3/im_beads_stressed_BD_1.tif');

beads_relaxed_low=	imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex3/im_beads_relaxed_BD_0.2.tif');
beads_stressed_low=imread('/home/wth/Downloads/SYNC/mechanobiology/TFM_assignment/TFM_group_01/ex3/im_beads_stressed_BD_0.2.tif');
%% Display the images
displayBeadOverlapping(beads_relaxed_high,beads_stressed_high)
title('Density of beads = 2%')

figure (1)
[ax,h]=subtitle('Density of beads = 1%');


displayBeadOverlapping(beads_relaxed_low,beads_stressed_low)
title('Density of beads = 0.2%')
figure (3)
[ax,h]=subtitle('Density of beads = 0.2%');

%% Calculate the displacement fields for each case
    
blkSize = 32; 
minCorr = 0.6;
minBeadInt_high = calcMinBeadInt(beads_relaxed_high);

[ux_high,uy_high] = calcNbeadDisp(beads_relaxed_high,beads_stressed_high,blkSize,minCorr,minBeadInt_high);
% Plot displacements
% displayDispField(ux_high,uy_high,1,0);
displayDispArrow(ux_high,uy_high,1,0);

minBeadInt_low = calcMinBeadInt(beads_relaxed_low);
[ux_low,uy_low] = calcNbeadDisp(beads_relaxed_low,beads_stressed_low,blkSize,minCorr,minBeadInt_low);
% Plot displacements
% displayDispField(ux_low,uy_low,1,0);
displayDispArrow(ux_low,uy_low,1,0);


