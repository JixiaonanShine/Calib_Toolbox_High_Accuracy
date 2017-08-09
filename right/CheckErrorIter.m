% % 用来计算整体误差值，却认别人的方法和自己的方法的差别
% 
% %% 迭代误差
% for i=1:1
% % load('Calib_Results_origin.mat');
% % eval(['DX=x_' num2str(i) ';'] );
% % load('Calib_Results_iter0.mat');
% % eval(['DDX=DX - x_' num2str(i) ';']);
% % figure; quiver(DX(1,:)',DX(2,:)',DDX(1,:)',DDX(2,:)')
% % hold on;
%     for jte = 7:7
%         load(['Calib_Results_iter' num2str(jte-1) '.mat']);
%         eval(['DX=x_' num2str(i) ';']);
%         load(['Calib_Results_iter' num2str(jte) '.mat']);
%         eval(['DDX=DX - x_' num2str(i) ';']);
%         figure;quiver(DX(1,:)',DX(2,:)',DDX(1,:)',DDX(2,:)');
%         SDDX = sqrt(DDX(1,:).^2 + DDX(2,:).^2);
%         MA = mean(SDDX);
%         MX = max(SDDX);
%         MIN = min(SDDX);
%         disp(['Mean ' num2str(MA) ' MaX ' num2str(MX) ' min' num2str(MIN)]);
%     end
% 
% % close all;
% % clc
% end

%% 公式误差
load('Calib_Results_iter_origin.mat');

for ita = 1:22
    eval(['rkk = omc_' num2str(ita),';']);
    eval(['tkk = Tc_' num2str(ita),';']);
    eval(['originx = x_' num2str(ita),';']);
    
    [repmap,dt] = project_points2(X_1,rkk,tkk,fc,cc,kc,alpha_c);

% load('Calib_Results_iter.mat','omc_*', 'Tc_*','fc','cc','kc','alpha_c');

% repmap2 = project_points2(X_1,omc_1,Tc_1,fc,cc,kc,alpha_c);

d = repmap - originx;
sd = sqrt(d(1,:).^2 + d(2,:).^2);
        MA = mean(sd);
        MX = max(sd);
        MIN = min(sd);
        disp(['Mean ' num2str(MA) ' MaX ' num2str(MX) ' min' num2str(MIN)]);
% hold on;
quiver(originx(1,:),originx(2,:),d(1,:),d(2,:));
x=reshape(originx(1,:),61,51);
y=reshape(originx(2,:),61,51);
z=reshape(sqrt(d(1,:).^2+d(2,:).^2),61,51);
surf(x,y,z)
end
% %% 迭代误差2
% load('Calib_Results_iter8.mat');
% repmap = project_points2(X_1,omc_1,Tc_1,fc,cc,kc,alpha_c);
% load('Calib_Results_iter7.mat');
% repmap2 = project_points2(X_1,omc_1,Tc_1,fc,cc,kc,alpha_c);
% d = repmap - repmap2;
% sd = sqrt(d(1,:).^2 + d(2,:).^2);
% MA = mean(sd);
% MX = max(sd);
% MIN = min(sd);
% disp(['Mean ' num2str(MA) ' MaX ' num2str(MX) ' min' num2str(MIN)]);
% quiver(x_1(1,:),x_1(2,:),d(1,:),d(2,:));