stereo_gui
load_stereo_calib_files
recompute_intrinsic_right=0;% ע�⣬ ��Ҫ�����ڲ�
recompute_intrinsic_left=0;
go_calib_stereo  %go_calib_stereo_power
clear;

rectify_stereo_pair



% Ҫ�����壬�������һ��ת���� �����ҶԳ�Ҳ��һ��ת����
%�������궨ʱ����Ҫ���ҵ�����һ��ͶӰ�����ܼ�ƽ��
%Xc = R*X + T
%R = rodrigues(om)
% Y = rigid_motion(X,om,T);

% Q������stereoRectify���  Q͸�ӱ任���� disparity �Ӳ�ͼ��
%sgbm((Mat)img1, (Mat)img2, disp); %������ֵ




% double q[] =
%         {
%             1, 0, 0, -cc_new[0].x,
%             0, 1, 0, -cc_new[0].y,
%             0, 0, 0, fc_new,
%             0, 0, -1./_t[0],c(c_new[0].x - cc_new[1].x)/_t[0]
%         };

%         double qx = q[0][1]*y + q[0][3], qy = q[1][1]*y + q[1][3];
%         double qz = q[2][1]*y + q[2][3], qw = q[3][1]*y + q[3][3];
%         for( x = 0; x < cols; x++, qx += q[0][0], qy += q[1][0], qz += q[2][0], qw += q[3][0] )
%         {
%             double d = sptr[x];
%             double iW = 1./(qw + q[3][2]*d);
%             double X = (qx + q[0][2]*d)*iW;
%             double Y = (qy + q[1][2]*d)*iW;
%             double Z = (qz + q[2][2]*d)*iW;
%         }
%reprojectImageTo3D(disp, xyz, Q, true); % ��ֵ����� ע��Q����


