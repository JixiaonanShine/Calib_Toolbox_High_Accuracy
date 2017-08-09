nsize = 64;
PeakRange = 16;
Tgaussian=3;
for I=1:n_ima
    if active_images(I)==0
        continue;
    end
    imOrigin = double(rgb2gray(imread(sprintf('../images/ImLeft%d.jpg',I-1))));
    tmpImg = zeros(size(imOrigin)+nsize);
    tmpImg(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2) = imOrigin;
    imOrigin = tmpImg;
    imRePrj = double(imread(sprintf('RndPrjNxt%d.tif',I)));
    tmpImg(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2) = imRePrj;
    imRePrj = tmpImg;
    
    X = imorigin';
     
    eval(['omc=omc_' num2str(I) ';']);
    eval(['Tc=Tc_' num2str(I) ';']);
    
    x_prjed = project_points2(X',omc,Tc,fc,cc,kc,alpha_c);
    x_prjed = x_prjed';
    x = x_prjed;%1 投影出来的x做为原始的x
    xnew = zeros(size(x));   
    pnew = zeros(size(x));
    x_prjed = x_prjed + nsize/2;
    for J=1:length(x_prjed)
        pt = floor(x_prjed(J,:));
        p1 = imOrigin(pt(2)-nsize/2+1:pt(2)+nsize/2,pt(1)-nsize/2+1:pt(1)+nsize/2); % p1 为ORIGIN  还有一个BUG 有的图在边缘
        p3 = imRePrj(pt(2)-nsize/2+1:pt(2)+nsize/2,pt(1)-nsize/2+1:pt(1)+nsize/2); % p2 为Reprj
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

        xnew(J,:) = [x(J,1)-px,x(J,2)-py];%2 叠加误差值
        pnew(J,:) = [-px,-py];
    end
    imOrigin = imOrigin(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2);
    imRePrj = imRePrj(nsize/2+1:end-nsize/2,nsize/2+1:end-nsize/2);
    
%     figure;image(imRePrj);colormap(gray(255));hold on;quiver(x(:,1),x(:,2),xnew(:,1)-x(:,1),xnew(:,2)-x(:,2));plot(x(:,1),x(:,2),'o');hold off;
%     hold on; 
% %     scatter(x(:,1),x(:,2)); 
% %     scatter(xnew(:,1),xnew(:,2)); 
%     quiver(x(:,1),x(:,2),xnew(:,1)-x(:,1),xnew(:,2)-x(:,2));
%     hold off;
    
    xnew = xnew';
    eval(['x_' num2str(I) '=xnew;']);
    eval(['X_' num2str(I) '=imorigin;']);
    %figure;image(imOrigin);colormap(gray(255));hold on; quiver(pt(1),pt(2),px,py);hold off;
end

