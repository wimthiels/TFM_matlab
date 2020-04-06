function [subpxXPeak,subpxYPeak] = subpxPeakCoord(xPeak,yPeak,c)
% SUBPXPEAKCOORD obtain subpixel precision for the correlation peak.
% INPUTS:
%   xPeak: X coordinate (column) of the correlation peak of matrix c.
%   yPeak: Y coordinate (row) of the correlation peak of matrix c.
%   c: correlation matrix
% OUTPUTS:
%   subpxXPeak: subpixel precision for the X coordinate of the correlation
%   peak (to be added to the integer version of the correlation peak coordinate).
%   subpxYPeak: subpixel precision for the Y coordinate of the correlation
%   peak (to be added to the integer version of the correlation peak coordinate).

rowPeak = yPeak;
colPeak = xPeak;

% Fit the peak to a second order polynomial along the rows
try 
    polyRow = polyfit([-1,0,1],reshape(c(rowPeak-1:rowPeak+1,colPeak),1,[]),2);
    subpxRowPeak = -polyRow(2)/(2*polyRow(1)); % Find the maximum location (subpixel accuracy) of the polynomial
catch
    subpxRowPeak = rowPeak;
end
% Fit the peak to a second order polynomial along the columns
try
    polyCol = polyfit([-1,0,1],reshape(c(rowPeak,colPeak-1:colPeak+1),1,[]),2);
    subpxColPeak = -polyCol(2)/(2*polyCol(1)); % Find the maximum location (subpixel accuracy) of the polynomial
catch
    subpxColPeak = colPeak;
end

subpxXPeak = subpxColPeak;
subpxYPeak = subpxRowPeak;
