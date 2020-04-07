
function minBeadInt = calcMinBeadInt(im)

%Binarize the image
BW = imbinarize(im,'adaptive');
%BW = imbinarize(im,'adaptive','ForegroundPolarity','bright','Sensitivity',0.01);
figure, imshow(BW)

%Get connected components
cc = bwconncomp(BW)

%Define a container where the bead intensity values will be stored
bead_int_vals = [];

%Loop through the connected components
for ii = 1:length(cc.PixelIdxList)
    %Access the pixel positions
    coordinates = cc.PixelIdxList{ii};
    
    %Check the intensity values of im in those positions
    intensities= im(coordinates);
    
    %Save the values in bead_int_vals
    bead_int_vals= [bead_int_vals, intensities]
end

%Compute the 50% of the average value
minBeadInt = mean(bead_int_vals,'all') * 0.5