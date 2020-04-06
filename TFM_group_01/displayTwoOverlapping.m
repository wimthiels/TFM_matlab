function displayTwoOverlapping(im1,im2)




imSize = size(im1);
im1 = double(im1); im2 = double(im2);
im1 = im1/max(im1(:)); im2 = im2/max(im2(:));


figure
subplot(1,2,1)
imagesc(im1)
colormap gray
axis image
axis off
title('Image 1')
subplot(1,2,2)
imagesc(im2)
colormap gray
axis image
axis off
title('Image 2')


figure
rgbIm = zeros([imSize,3]);
rgbIm(:,:,1) = im1;
rgbIm(:,:,2) = im2;
image(rgbIm)
axis image
axis off
title('Overlay of both Images')