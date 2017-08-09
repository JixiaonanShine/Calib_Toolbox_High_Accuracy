The toolbox also includes a function stereo_triangulation.m that computes the 3D location of a set of points given their left and right image projections. 
This process is known as stereo triangulation. To learn about the syntax of the function type help stereo_triangulation in the main Matlab window. 
As an exercise, let's apply the triangulation function on a simple example: let's re-compute the 3D location of the grids points extracted on the 
first image pair {left01.jpg, right01.jpg}. After running through the complete stereo calibration example, the image projections of the grid points
 on the right and left images are available in the variables x_left_1 and x_right_1. In order to triangulate those points in space, 
invoke stereo_triangulation.m by inputting x_left_1,x_right_1, the extrinsic stereo parameters om and T and the left and right camera intrinsic parameters:

[Xc_1_left,Xc_1_right] = stereo_triangulation(x_left_1,x_right_1,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);

The output variables Xc_1_left and Xc_1_right are the 3D coordinates of the points in the left and right camera reference frames respectively 
(observe that Xc_1_left and Xc_1_right are related to each other through the rigid motion equation Xc_1_right = R * Xc_1_left + T ). 
It may be interesting to see that one can then re-compute the "intrinsic" geometry of the calibration grid from the triangulated structure Xc_1_left 
by undoing the left camera location encoded by Rc_left_1 and Tc_left_1:

X_left_approx_1 = Rc_left_1' * (Xc_1_left - repmat(Tc_left_1,[1 size(Xc_1_left,2)]));

The output variable X_left_approx_1 is then an approximation of the original 3D structure of the calibration grid stored in X_left_1. How well do they match? 


fc=[f/dx f/dy];f是焦距，dx、dy分别代表横纵一个像素的物理尺寸


clc
clear
load('Calib_Results_stereo.mat');
[Xc_1_left,Xc_1_right] = stereo_triangulation(x_left_1,x_right_1,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right);
Rc_left_1 = rodrigues(omc_left_1);
X_left_approx_1 = Rc_left_1' * (Xc_1_left - repmat(Tc_left_1,[1 size(Xc_1_left,2)]));% 重回到物理点

R = rodrigues(om);
Xc_1_right_other = R * Xc_1_left + repmat(T,[1 size(Xc_1_left,2)]);
d = Xc_1_right - Xc_1_right_other;