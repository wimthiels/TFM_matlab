function [ux,uy] = calcNbeadDisp(im1,im2,blkSize,minCorr,minBeadInt)

%% Calculate blkNum

blkNum(1)=floor(size(im1,2)/blkSize) %x-dim
blkNum(2)=floor(size(im1,1)/blkSize) %y-dim

%% Define ux and uy
ux=zeros(blkNum(2),blkNum(1)); % size = (Y,X)
uy=zeros(blkNum(2),blkNum(1));

%% Scan im1 and im2 block by block 

for ii= 1:blkNum(1)
    for jj= 1:blkNum(2)
        x_pos = ii * blkSize;
        y_pos = jj * blkSize;
        blkIm1 = im1(y_pos - blkSize + 1:y_pos, x_pos - blkSize + 1:x_pos);
        blkIm2 = im2(y_pos - blkSize + 1:y_pos, x_pos - blkSize + 1:x_pos);
        
        if max(blkIm1,[],'all') < minBeadInt
            continue
        end
        if max(blkIm2,[],'all') < minBeadInt
            continue
        end
            
        [s,corrvalue]  = shiftCalc(blkIm1,blkIm2); %s = [xoffSet,yoffSet]
        
        if corrvalue < minCorr
            continue
        end
        
        ux(jj,ii) = s(1);
        uy(jj,ii) = s(2);
     end
 end
