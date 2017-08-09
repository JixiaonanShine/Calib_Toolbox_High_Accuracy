
clc
clear 
I    = imread('ImLeft5.jpg');    % Original: also test 2.jpg
bw   = 0.1; 
[Ims2, Nms2] = Meanshift(I,bw);                   % Mean Shift (color + spatial)
% imshow(label2rgb(uint8(Ims(:,:,1)./min(min(Ims(:,:,1))))));  title(['MeanShift',' : ',num2str(Nms)]);
IM2 = Ims2(:,:,1);%+Ims2(:,:,2)+Ims2(:,:,3)
imshow(label2rgb(uint8(IM2./min(min(IM2))))); title(['MeanShift+Spatial',' : ',num2str(Nms2)]);


