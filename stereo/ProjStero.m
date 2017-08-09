stereo_gui
load_stereo_calib_files
recompute_intrinsic_right=0;% 注意， 不要重算内参
recompute_intrinsic_left=0;
go_calib_stereo  %go_calib_stereo_power
clear;

rectify_stereo_pair



% 要做立体，对相机是一次转换。 对左右对称也有一次转换。
%相机立体标定时，需要从右到左做一次投影，才能极平行
%Xc = R*X + T
%R = rodrigues(om)
% Y = rigid_motion(X,om,T);

% Q矩阵由stereoRectify输出  Q透视变换矩阵。 disparity 视差图像
%sgbm((Mat)img1, (Mat)img2, disp); %相关算差值




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
%reprojectImageTo3D(disp, xyz, Q, true); % 差值算距离 注意Q矩阵


