function [tx,ty] = tractionRetrieval(ux,uy,young,poisson,dispResXY)

% Generate coordinate grids for displacements
dispFieldSize = size(ux);
[dXcoord, dYcoord] = meshgrid((-(dispFieldSize(2)-1)/2:1:(dispFieldSize(2)-1)/2),(-(dispFieldSize(1)-1)/2:1:(dispFieldSize(1)-1)/2));
dXcoord = dXcoord*dispResXY;
dYcoord = dYcoord*dispResXY;
dispCoord = [dXcoord(:),dYcoord(:)];
% Generate coordinate grids for tractions
tracFieldSize = dispFieldSize;
[tXcoord, tYcoord] = meshgrid((-(tracFieldSize(2)-1)/2:1:(tracFieldSize(2)-1)/2),(-(tracFieldSize(1)-1)/2:1:(tracFieldSize(1)-1)/2));
tracResXY =dispResXY;
tXcoord = tXcoord*tracResXY;
tYcoord = tYcoord*tracResXY;
tracCoord = [tXcoord(:),tYcoord(:)];
% Calculate the stiffness matrix
sM =stiffMtx(dispCoord,tracCoord,tracResXY,young,poisson);
% Reshape the displacement field to arrange it in a column-vector
dispVec = [ux(:) ; uy(:)]; 


%% Invert the stiffness matrix and calculate the tractions (TO DO)


%...

%%
% Re-arrange the tractions
tPosNum = length(tractVec)/2;
tx = reshape(tractVec(1:tPosNum),tracFieldSize(1),tracFieldSize(2));
ty = reshape(tractVec(tPosNum+1:end),tracFieldSize(1),tracFieldSize(2));