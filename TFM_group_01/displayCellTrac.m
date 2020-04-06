function displayCellTrac(tx,ty,tracResXY,cellIm,blkSize)


cellIm = imresize(double(cellIm),blkSize);

t_mag = sqrt(tx.^2 + ty.^2);

% only show the info of the 85% largest vectors
tx(t_mag<(max(t_mag(:))*(15/100))) = nan;
ty(t_mag<(max(t_mag(:))*(15/100))) = nan;



tracFieldSize = size(tx);

[dXcoord, dYcoord] = meshgrid((-(tracFieldSize(2)-1)/2:1:(tracFieldSize(2)-1)/2),(-(tracFieldSize(1)-1)/2:1:(tracFieldSize(1)-1)/2));
dXcoord = dXcoord*tracResXY;
dYcoord = dYcoord*tracResXY; 





figure
imagesc(dXcoord(1,:),dYcoord(:,1)',cellIm)
colormap gray
hold on
quiver(dXcoord,dYcoord,tx,ty,'Color',[0.2, 0.6, 1],'LineWidth',2,'MaxHeadSize',0.7,'AutoscaleFactor',3)
hold off
axis image
axis off
title('Tractions: orientation (Arrows) over the cell image')



