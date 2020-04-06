function displayTracField(tx,ty,tracResXY)


tx = tx*1000; % units in Pa
ty = ty*1000; % units in Pa



t_mag = sqrt(tx.^2 +ty.^2);

tracFieldSize = size(tx);

[dXcoord, dYcoord] = meshgrid((-(tracFieldSize(2)-1)/2:1:(tracFieldSize(2)-1)/2),(-(tracFieldSize(1)-1)/2:1:(tracFieldSize(1)-1)/2));
dXcoord = dXcoord*tracResXY;
dYcoord = dYcoord*tracResXY;



figure

subplot(1,3,1)
imagesc(dXcoord(1,:),dYcoord(:,1)',tx)
colormap jet
colorbar
axis image
title('Tractions: tx')

subplot(1,3,2)
imagesc(dXcoord(1,:),dYcoord(:,1)',ty)
colormap jet
colorbar
axis image
title('Tractions: ty')

subplot(1,3,3)
imagesc(dXcoord(1,:),dYcoord(:,1)',t_mag)
colormap jet
colorbar
axis image
title('Tractions: magnitude')

