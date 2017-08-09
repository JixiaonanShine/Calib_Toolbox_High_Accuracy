clc
clear
load('Calib_Results_stereo.mat');

% Xc_1_left 像平面图， 去畸变，去中心点。  
% Xc_1_left and Xc_1_right are the 3D coordinates of the points in the left and right camera reference frames respectively
xleft = [1322.5;519.5];
xleft=[xleft,[159;340]];
xright = [1196.5;601.5];
xright=[xright,[87;364]];
[Xc_1_left,Xc_1_right] = stereo_triangulation(xleft,xright,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);
Rc_left_1 = rodrigues(omc_left_1);
%Pl = Rl*Pw+Tl ==>  Pw = Rl'(Pl-Tl);
X_left_approx_1 = Rc_left_1' * (Xc_1_left - repmat(Tc_left_1,[1 size(Xc_1_left,2)]));% 重回到物理点
d = X_left_approx_1 - X_left_1;