function displayDispArrow(ux,uy,dispResXY,filtFlag)

u_mag = sqrt(ux.^2 +uy.^2);

dispFieldSize = size(ux);

[dXcoord, dYcoord] = meshgrid((-(dispFieldSize(2)-1)/2:1:(dispFieldSize(2)-1)/2),(-(dispFieldSize(1)-1)/2:1:(dispFieldSize(1)-1)/2));
dXcoord = dXcoord*dispResXY;
dYcoord = dYcoord*dispResXY;


% only show the arrows of the 95% largest vectors
ux(u_mag<(max(u_mag(:))*(5/100))) = nan;
uy(u_mag<(max(u_mag(:))*(5/100))) = nan;

figure

imagesc(dXcoord(1,:),dYcoord(:,1)',u_mag)
colormap jet
hold on
quiver(dXcoord,dYcoord,ux,uy,'Color','w','LineWidth',2,'MaxHeadSize',0.7,'AutoscaleFactor',3)
hold off
colorbar
axis image
if filtFlag
    title('Filt Disp: magnitude (colormap) and direction (arrows)')
else
    title('Disp: magnitude (colormap) and direction (arrows)')
end




