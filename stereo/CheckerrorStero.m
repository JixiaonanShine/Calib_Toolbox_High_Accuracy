clear 
close all;
clc;
load('Calib_Results_right.mat');
kk=1;
eval(['omcrkk = omc_' num2str(kk) ';']);
eval(['Tcrkk = Tc_' num2str(kk) ';']);
clearvars -except kk omcrkk Tcrkk

load('Calib_Results_stereo.mat');

eval(['Xckk = X_left_' num2str(kk) ';']);
eval(['omclkk = omc_left_' num2str(kk) ';']);
eval(['Tclkk = Tc_left_' num2str(kk) ';']);
            
eval(['xlkk = x_left_' num2str(kk) ';']);
eval(['xrkk = x_right_' num2str(kk) ';']);


% 这里有BUG， 应该是像到物的投影函数，而不是物到像的。
[xl] = project_points2(Xckk,omclkk,Tclkk,fc_left,cc_left,kc_left,alpha_c_left);
[xr] = project_points2(Xckk,omcrkk,Tcrkk,fc_right,cc_right,kc_right,alpha_c_right);

% figure;scatter(xl(1,:),xl(2,:));
% figure;scatter(xr(1,:),xr(2,:));

sz = size(xl);
DL = ones(sz(1)+1,sz(2));
DL(1:2,:) = xr;


Y = rigid_motion(DL,-om,-T);
% inv_Z = 1./Y(3,:);
% x = (Y(1:2,:) .* (ones(2,1) * inv_Z)) ;
DL = Y;

% 
% R = rodrigues(om);
% DL = R'*DL ;
oxr = [DL(1,:);DL(2,:)];
% figure; scatter(oxr(1,:),oxr(2,:));
d = xl - oxr;
quiver(xl(1,:),xl(2,:),d(1,:),d(2,:))
sd = sqrt(d(1,:).^2 + d(2,:).^2);
MA = mean(sd);
MX = max(sd);
MIN = min(sd);
disp(['Mean ' num2str(MA) ' MaX ' num2str(MX) ' min' num2str(MIN)]);
