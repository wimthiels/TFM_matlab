function displayDispField(ux,uy,dispResXY,filtFlag)

u_mag = sqrt(ux.^2 +uy.^2);

dispFieldSize = size(ux);

[dXcoord, dYcoord] = meshgrid((-(dispFieldSize(2)-1)/2:1:(dispFieldSize(2)-1)/2),(-(dispFieldSize(1)-1)/2:1:(dispFieldSize(1)-1)/2));
dXcoord = dXcoord*dispResXY;
dYcoord = dYcoord*dispResXY;



figure

subplot(1,3,1)
imagesc(dXcoord(1,:),dYcoord(:,1)',ux)
colormap jet
colorbar
axis image
if filtFlag
    title('Filt Disp: ux')
else
    title('Disp: ux')
end

subplot(1,3,2)
imagesc(dXcoord(1,:),dYcoord(:,1)',uy)
colormap jet
colorbar
axis image
if filtFlag
    title('Filt Disp: uy')
else
    title('Disp: uy')
end
    

subplot(1,3,3)
imagesc(dXcoord(1,:),dYcoord(:,1)',u_mag)
colormap jet
colorbar
axis image
if filtFlag
    title('Filt Disp: magnitude')
else
    title('Disp: magnitude')
end







