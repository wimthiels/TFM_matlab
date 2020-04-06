function out = cropIm(im,blkSize)

imSize = size(im);
% Crop images
cropVal = imSize - blkSize*floor(imSize/blkSize);
crop1 = floor(cropVal(1)/2);
crop2 = floor(cropVal(2)/2);
if rem(cropVal(1),2) % if it is odd
    if rem(cropVal(2),2) % if it is odd
        out = im(crop1+1:end-(crop1+1),crop2+1:end-(crop2+1));
    else
        out = im(crop1+1:end-(crop1+1),crop2+1:end-crop2);
    end
else
    if rem(cropVal(2),2) % if it is odd
        out = im(crop1+1:end-crop1,crop2+1:end-(crop2+1));
    else
        out = im(crop1+1:end-crop1,crop2+1:end-crop2);
    end
end