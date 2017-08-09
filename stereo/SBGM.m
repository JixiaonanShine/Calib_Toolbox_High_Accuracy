%%% 这里有问题. 问题似乎出在rectify上

I1 = imread('ImLeft_rectified4.bmp');
I2 = imread('ImRight_rectified4.bmp');
D = disparity((I1), (I2), 'DisparityRange',[16 240]);%, 'Method','BlockMatching'
D(D<-5000)=0;
xyz=reprojectImageTo3D(D,Q);
k=xyz(:,:,3);
k(abs(k)<0.00001)=0;
k(isinf(k))=0;
figure;imagesc(I1)
% imshow(stereoAnaglyph(I1,I2));