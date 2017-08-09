clc
clear
load('Calib_Results_stereo.mat');

% Xc_1_left 像平面图， 去畸变，去中心点。  
% Xc_1_left and Xc_1_right are the 3D coordinates of the points in the left and right camera reference frames respectively
[Xc_1_left,Xc_1_right] = stereo_triangulation(x_left_1,x_right_1,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);

% % check Xc_1_left
% Xc_1_left_ori = [x_left_1(1,:) - cc_left(1); x_left_1(2,:) - cc_left(2)];
% Xc_1_left_d = Xc_1_left_ori - Xc_1_left(1:2,:);

Rc_left_1 = rodrigues(omc_left_1);
%Pl = Rl*Pw+Tl ==>  Pw = Rl'(Pl-Tl);
X_left_approx_1 = Rc_left_1' * (Xc_1_left - repmat(Tc_left_1,[1 size(Xc_1_left,2)]));% 重回到物理点
d = X_left_approx_1 - X_left_1;

% d=X_left_approx_1-X_right_1;
quiver(X_left_1(1,:),X_left_1(2,:),d(1,:),d(2,:));