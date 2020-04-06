function sM =stiffMtx(dispCoord,forceCoord,resXY,young,poisson)





% We want to do the computations using the folowing units:
% Force = nN
% Displacement = um
% Area = um^2

% KPa = 10^3Pa = 10^3N/m^2 = (10^3 * 10^9) / (10^12) nN/um^2 = 1  nN/um^2


% resXY = resolution in the xy plane (equal for both x and y). Units in um
% poisson = Poisson's ratio
% young = Young's modulus (units KPa)





format long


gIntegrationSize = resXY *(1 -(2/100)); % units in um
if length(gIntegrationSize)<2
    tmp = gIntegrationSize;
    gIntegrationSize = [tmp tmp]; clear tmp
end




% Main loop
dPosNum = size(dispCoord,1); 
fPosNum = size(forceCoord,1); 
sM = zeros(2*dPosNum,2*fPosNum);
for ii=1:dPosNum    
   x = dispCoord(ii,1) - forceCoord(:,1);
   y = dispCoord(ii,2) - forceCoord(:,2);
   g=greenFunc(x,y,young,poisson,gIntegrationSize);
   sM(ii,:) = [reshape(g.g11,1,[]), reshape(g.g12,1,[])];
   sM(dPosNum+ii,:) = [reshape(g.g21,1,[]), reshape(g.g22,1,[])];
   clear x y g
end






end



function g=greenFunc(x,y,E,sigma,gIntegrationSize)

% Green function for TFM (Boussinesq equation for the Half Space approximation)
% output is formatted as struct:
%  g.g11 = g_xx
%  g.g12 = g_xy
%  g.g21 = g_yx
%  g.g22 = g_yy


% integration limits for the rectangular area
% area size = (2*limitX   *   2*limitY)
limitX = gIntegrationSize(1)/2; % units in um
limitY = gIntegrationSize(2)/2; % unts in um

% Useful variables
v1 = limitX-x;
v2 = -limitX-x;
v3 = limitY-y;
v4 = -limitY-y;
R1 = sqrt(v1.^2 + v3.^2);
R2 = sqrt(v1.^2 + v4.^2);
R3 = sqrt(v2.^2 + v3.^2);
R4 = sqrt(v2.^2 + v4.^2);

clear x y

% Pre-Computations
pc1 = v3.*log((v1 + R1)./(v2+R3));
pc2 = v4.*log((v1 + R2)./(v2+R4));
pc3 = v1.*log((v3 + R1)./(v4+R2));
pc4 = v2.*log((v3 + R3)./(v4+R4));

clear v1 v2 v3 v4

% Formula for g11
g11_a = 2*(pc1 - pc2);
g11_b = pc3 - pc4;
g11_c = (1-(2*sigma))*(pc3 - pc4);
g.g11 = ((1+sigma)/(2*pi*E))*(g11_a + g11_b + g11_c);
clear g11_a g11_b g11_c
% Formula for g12
g.g12 = ((sigma*(1+sigma))/(pi*E))*(-R1 + R2 +R3 -R4);
clear R1 R2 R3 R4
% Formula for g21
g.g21 = g.g12;
% Formula for g22
g22_a = 2*(pc3 - pc4);
g22_b = pc1 - pc2;
g22_c = (1-(2*sigma))*(pc1 - pc2);
g.g22 = ((1+sigma)/(2*pi*E))*(g22_a + g22_b + g22_c);
clear g22_a g22_b g22_c
clear pc1 pc2 pc3 pc4



end
