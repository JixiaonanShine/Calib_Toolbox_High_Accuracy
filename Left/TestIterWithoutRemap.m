% 不重投的迭代，尝试修正公式误差。
for iTer=9:10
    clearvars -except iTer;
    load(['Calib_Results_iter',num2str(iTer-1),'.mat']);
%     est_dist = [1,1,1,1,1]';
    go_calib_optim_iter;
    str = ['Calib_Results_iter',num2str(iTer),'.mat'];
    save(str,'omc_*', 'Tc_*','x_*','X_*','center_optim','param_list', 'active_images', 'ind_active',  ...
    'est_alpha', 'est_dist', 'est_aspect_ratio', 'est_fc', 'fc', 'kc', 'cc', 'alpha_c', 'fc_error', 'kc_error', 'cc_error', ...
    'alpha_c_error', 'err_std', 'ex', 'x', 'y', 'solution', 'solution_init', 'wintx', 'winty', 'n_ima', 'type_numbering', 'N_slots', 'small_calib_image', 'first_num', 'image_numbers', 'format_image',  ...
    'calib_name', 'Hcal', 'Wcal', 'nx', 'ny', 'map', 'dX_default', 'dY_default', 'KK', 'inv_KK', 'dX', 'dY', 'wintx_default', 'winty_default', 'no_image', 'check_cond', 'MaxIter');
end