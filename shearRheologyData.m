clear;close all; clc;

%% Visualize data

% Load the rheology data
data=importdata('ex4\collagenData.txt')

%Obtain the variables
stress_data =data.data(:,1);
strain_data =data.data(:,2);

%Plot the stress-strain curve

figure
plot(strain_data,stress_data);
xlabel('strain [%]')
ylabel('stress [Pa]');
title('full stress-strain curve')


%% Compute the Young's modulus

%Crop only the linear part
ind=find(strain_data<9.5 & strain_data>6);

linear_stress =stress_data(ind);
linear_strain =strain_data(ind);

%Fit a line to the data

[f,g]=fit(linear_strain,linear_stress,'poly1');
e_modulus=f.p1*100;
y_fit=f.p1*linear_strain+f.p2;
% e_modulus=linear_strain(:)\linear_stress(:);
% y_fit=e_modulus*linear_strain;


%Plot the data and the fitted curve
figure
hold on
plot(linear_strain,linear_stress,'o')
plot(linear_strain,y_fit,'-') 
legend('data','linear fit') 
xlabel('Strain')
ylabel('Shear stress (Pa)');
title(['Computed Elastic modulus = ' num2str(e_modulus) , ' Pa']);

