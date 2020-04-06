
function minBeadInt = calcMinBeadInt(im)

%Binarize the image
% TO DO

%Get connected components
% TO DO
% cc = 

%Define a container where the bead intensity values will be stored
bead_int_vals = [];

%Loop through the connected components
for ii = 1:length(cc.PixelIdxList)
    %Access the pixel positions
    coordinates = cc.PixelIdxList{ii};
    
    %Check the intensity values of im in those positions
    % TO DO
    
    %Save the values in bead_int_vals
    % TO DO
end

%Compute the 50% of the average value
%TO DO