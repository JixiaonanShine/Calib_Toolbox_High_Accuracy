clear;
load('Calib_Results_origin.mat');
ProjFromPyNxt;
clear;
load('Calib_Results_origin.mat')

[my,mx] = meshgrid(0:5:375,0:5:255);
my=fliplr(my);
px = reshape(mx,52*76,1);
py = reshape(my,52*76,1);
imorigin = [px,py,zeros(length(px),1)]';

ReCalibByRnd; % 注意里面的图片名字。
% save('0.mat','x_*','X_*');

% load('0.mat');
est_alpha=1;
est_dist = [1;1;1;1;1];
go_calib_optim_iter;

save('Calib_Results_iter0.mat','omc_*', 'Tc_*','x_*','X_*','center_optim','param_list', 'active_images', 'ind_active',  ...
    'est_alpha', 'est_dist', 'est_aspect_ratio', 'est_fc', 'fc', 'kc', 'cc', 'alpha_c', 'fc_error', 'kc_error', 'cc_error', ...
    'alpha_c_error', 'err_std', 'ex', 'x', 'y', 'solution', 'solution_init', 'wintx', 'winty', 'n_ima', 'type_numbering', 'N_slots', 'small_calib_image', 'first_num', 'image_numbers', 'format_image',  ...
    'calib_name', 'Hcal', 'Wcal', 'nx', 'ny', 'map', 'dX_default', 'dY_default', 'KK', 'inv_KK', 'dX', 'dY', 'wintx_default', 'winty_default', 'no_image', 'check_cond', 'MaxIter');



for iTer=1:5
    %if iTer>1
        clearvars -except iTer;
        load(['Calib_Results_iter',num2str(iTer-1),'.mat']);
        ProjFromPyNxt;
    %end
    clearvars -except iTer;
    load(['Calib_Results_iter',num2str(iTer-1),'.mat']);
 
    [my,mx] = meshgrid(0:5:375,0:5:255);
    my=fliplr(my);
    px = reshape(mx,52*76,1);
    py = reshape(my,52*76,1);
    imorigin = [px,py,zeros(length(px),1)]';

    ReCalibByRnd;
    est_dist = [1;1;1;1;1];
    est_alpha=1;
    go_calib_optim_iter;
    str = ['Calib_Results_iter',num2str(iTer),'.mat'];
    save(str,'omc_*', 'Tc_*','x_*','X_*','center_optim','param_list', 'active_images', 'ind_active',  ...
    'est_alpha', 'est_dist', 'est_aspect_ratio', 'est_fc', 'fc', 'kc', 'cc', 'alpha_c', 'fc_error', 'kc_error', 'cc_error', ...
    'alpha_c_error', 'err_std', 'ex', 'x', 'y', 'solution', 'solution_init', 'wintx', 'winty', 'n_ima', 'type_numbering', 'N_slots', 'small_calib_image', 'first_num', 'image_numbers', 'format_image',  ...
    'calib_name', 'Hcal', 'Wcal', 'nx', 'ny', 'map', 'dX_default', 'dY_default', 'KK', 'inv_KK', 'dX', 'dY', 'wintx_default', 'winty_default', 'no_image', 'check_cond', 'MaxIter');
end

    saving_calib;
    !rename Calib_Results.mat Calib_Results_left.mat

