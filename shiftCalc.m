function [s,corrValue] = shiftCalc(im_relaxed,im_stressed)
%{
calculate the 2D shifts between two images using the normalized cross-correlation
algorithm
Inputs: im_relaxed, im_stressed
Outputs:
-s: the shift of im2 respect im1. It should contain both the displacements in the X and Y
direction: s=[dispX, dispY].
-corrVal: maximum value of the correlation peakn goes here
%}
c = normxcorr2(im_relaxed,im_stressed);
%figure, surf(c), shading flat

corrValue = max(c(:));
[ypeak, xpeak] = find(c==corrValue);
%sprintf('xpeak %g ,ypeak %g',xpeak,ypeak)
yoffSet = ypeak-size(im_stressed,1);
xoffSet = xpeak-size(im_stressed,2);

%add subpixel accuracy
[subppxXPeak, subpxYPeak] = subpxPeakCoord(xpeak,ypeak,c)
xoffSet = xoffSet + subppxXPeak
yoffSet = yoffSet + subpxYPeak

s = [xoffSet,yoffSet];

end

