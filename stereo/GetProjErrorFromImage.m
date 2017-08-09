function [ err ] = GetProjErrorFromImage( Im,ImagePath,ImageName,Count,x_prjed)
% δ���. ��ProjFromPy���������ͼ, ��NrndPrjXX.tif�����µı궨����֮��. ��RndPrj����.

% load('Calib_Results_origin.mat');
nsize = 64;
PeakRange = 16;
Tgaussian=3;

    imOrigin = double(rgb2gray(imread(sprintf([ImagePath '\\' ImageName '%02d.jpg'],Count))));
    tmpImg = zeros(size(imOrigin)+nsize);
    tmpImg(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2) = imOrigin;
    imOrigin = tmpImg;
    
    imRePrj = double(Im);
    tmpImg(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2) = imRePrj;
    imRePrj = tmpImg;
    
    x = x_prjed';
    x_prjed = x;
%     xnew = zeros(size(x_prjed));
    pnew = zeros(size(x));
    x_prjed = x_prjed + nsize/2;
    for J=1:length(x_prjed)
        pt = floor(x_prjed(J,:));
        p1 = imOrigin(pt(2)-nsize/2+1:pt(2)+nsize/2,pt(1)-nsize/2+1:pt(1)+nsize/2); % p1 ΪORIGIN  ����һ��BUG �е�ͼ�ڱ�Ե
        p3 = imRePrj(pt(2)-nsize/2+1:pt(2)+nsize/2,pt(1)-nsize/2+1:pt(1)+nsize/2); % p2 ΪReprj
        p1=mat2gray(p1);
        p3=mat2gray(p3);
        out=xcorrf2(p3,p1,'yes','phase');
        D=out;
        b=fspecial('gaussian',[9 9],1);
        D=imfilter(out,b);
        for K=1:Tgaussian-1
            D=imfilter(D,b);
        end
        [dy,dx]=find(D==max(max(D(nsize-PeakRange+1:nsize+PeakRange,nsize-PeakRange+1:nsize+PeakRange))));
        [px,py]=Eintpeak(dx,dy,(D(dy-1:dy+1,dx-1:dx+1)),nsize);

%         xnew(J,:) = [x(J,1)-px,x(J,2)-py];%2 �������ֵ
        pnew(J,:) = [-px,-py];
    end
    err = pnew';



