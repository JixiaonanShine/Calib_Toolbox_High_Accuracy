% % ���Ե������
% % ������1 ��ؼ����� 2 ��ʽ�������ص���2
% load('Calib_Results_left.mat')
% [my,mx] = meshgrid(0:5:250,0:5:300);
% my=fliplr(my);
% px = reshape(mx,51*61,1);
% py = reshape(my,51*61,1);
% imorigin = [px,py,zeros(length(px),1)]';
% ReCalibByRnd_eros; % ע�������ͼƬ���֡�
% 
% % manual save pnew �ֶ���pnew �Խ�������ļ��㣬ע�⣬��Ҫ�ֶ�ֹͣ��
% 

    eval(['rkk = omc_' num2str(1),';']);
    eval(['tkk = Tc_' num2str(1),';']);
    eval(['originx = x_' num2str(1),';']);
repmap = project_points2_eros(X_1,rkk,tkk,fc,cc,kc,alpha_c);

% load('Calib_Results_iter.mat','omc_*', 'Tc_*','fc','cc','kc','alpha_c');

% repmap2 = project_points2(X_1,omc_1,Tc_1,fc,cc,kc,alpha_c);

d = repmap - originx;
pnewa = -pnew';
dd = d-pnewa;

% ���ϡ�
%��ؼ���õ��Ľ���ͼ�ȥԭ�� x����10-5  y���� 10-6 
%Ҳ����˵������㾫��OK������ʽ�����������㡣


originx = originx+pnewa;
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

% ȥ���Ǹ��ṹ�� 5�ζ���ʽ����������Mean 0.0012931 MaX 0.01714 min6.8131e-06 �ľ���
% ����Ҫ�����Ƶ�project_points2�Ĺ�ʽ��
% �����Ǹ��ṹ��ʱ�� 5�ζ���ʽֻ��������Mean 0.02987 MaX 0.096008 min0.00089723