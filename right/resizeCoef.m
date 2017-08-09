%%% 缩放2倍 得到的结果 
% kc alpha_c 没变
% fc cc  原值/2
% om t 不变.
load('Calib_Results_iter5.mat');

est_alpha=1;
est_dist = [1;1;1;1;1];

for I=1:n_ima
    if active_images(I)==0
        continue;
    end
    eval(['x_' num2str(I) '=x_' num2str(I) './2;']);
%     eval(['Tc=Tc_' num2str(I) ';']);
end

go_calib_optim_iter;