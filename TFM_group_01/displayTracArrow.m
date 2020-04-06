function displayTracArrow(tx,ty,tracResXY)



tx=tx*1000; % units in Pa
ty=ty*1000; % units in Pa





t_mag = sqrt(tx.^2 + ty.^2);

% only show the info of the 85% largest vectors
tx(t_mag<(max(t_mag(:))*(15/100))) = nan;
ty(t_mag<(max(t_mag(:))*(15/100))) = nan;
t_mag(t_mag<(max(t_mag(:))*(15/100))) = nan;


tracFieldSize = size(tx);

[dXcoord, dYcoord] = meshgrid((-(tracFieldSize(2)-1)/2:1:(tracFieldSize(2)-1)/2),(-(tracFieldSize(1)-1)/2:1:(tracFieldSize(1)-1)/2));
dXcoord = dXcoord*tracResXY;
dYcoord = dYcoord*tracResXY; 





figure
imagesc(dXcoord(1,:),dYcoord(:,1)',t_mag)
colormap jet
hold on
quiver(dXcoord,dYcoord,tx,ty,'Color','w','LineWidth',2,'MaxHeadSize',0.7,'AutoscaleFactor',3)
hold off
colorbar
axis image
title('Tractions: magnitude (colormap) and direction (arrows)')




