
% 测试55阶方程是否可以描述误差。
load('Calib_Results_left.mat');

for ita = 1:22
    eval(['rkk = omc_' num2str(ita),';']);
    eval(['tkk = Tc_' num2str(ita),';']);
    eval(['originx = x_' num2str(ita),';']);
    [BX,BY,XR,YR]=LeastSqure55SC(X_1(1,:)',X_1(2,:)',1,originx(1,:)',originx(2,:)',0,1);%,0,125,125,150,150
%     [BX,BY]=LeastSqure13SC(X_1(1,:)',X_1(2,:)',1,originx(1,:)',originx(2,:)',0,1,0,540,540,960,960);
%     [XR,YR]=LeastSqure13SC(BX,BY,1,X_1(1,:)',X_1(2,:)',1,1,0,540,540,960,960);
    dx = XR - originx(1,:)';
    dy = YR - originx(2,:)';
    
    d = [dx,dy]';
sd = sqrt(d(1,:).^2 + d(2,:).^2);
        MA = mean(sd);
        MX = max(sd);
        MIN = min(sd);
        disp(['Mean ' num2str(MA) ' MaX ' num2str(MX) ' min' num2str(MIN)]);
        quiver(originx(1,:),originx(2,:),d(1,:),d(2,:));
end