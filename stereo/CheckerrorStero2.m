clc
clear
load('Calib_Results_stereo.mat');
d=[];
for I=1:24
    if active_images(I)==0
        continue;
    end
    % Xc_1_left 像平面图， 去畸变，去中心点。  
    % Xc_1_left and Xc_1_right are the 3D coordinates of the points in the left and right camera reference frames respectively
    eval(['x_left = x_left_' num2str(I) ';']);
    eval(['x_right = x_right_' num2str(I) ';']);
    [Xc_left,Xc_right] = stereo_triangulation(x_left,x_right,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);

    det = Xc_left-Xc_right;
    % % % check Xc_1_left
    % % Xc_1_left_ori = [x_left_1(1,:) - cc_left(1); x_left_1(2,:) - cc_left(2)];
    % % Xc_1_left_d = Xc_1_left_ori - Xc_1_left(1:2,:);
    % d1 = Xc_1_left-Xc_1_right;

    
    eval(['omc_left = omc_left_' num2str(I) ';']);
    eval(['Tc_left = Tc_left_' num2str(I) ';']);
    Rc_left = rodrigues(omc_left);
    %Pl = Rl*Pw+Tl ==>  Pw = Rl'(Pl-Tl);
    X_left_approx = Rc_left' * (Xc_left - repmat(Tc_left,[1 size(Xc_left,2)]));% 重回到物理点
    d = [d,X_left_approx - X_left_1];


%     eval(['omc_right = omc_right_' num2str(I) ';']);
%     eval(['Tc_right = Tc_right_' num2str(I) ';']);
%     Rc_right = rodrigues(omc_right);
%     %Pl = Rl*Pw+Tl ==>  Pw = Rl'(Pl-Tl);
%     X_right_approx = Rc_right' * (Xc_right - repmat(Tc_right,[1 size(Xc_right,2)]));% 重回到物理点
%     d = [d,X_right_approx - X_left_1];

end
    figure;plot(d(3,:));
% d=X_left_approx_1-X_right_1;
% quiver(X_left_1(1,:),X_left_1(2,:),d(1,:),d(2,:));

