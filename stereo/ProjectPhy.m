function Vq = ProjectPhy(phyImg, omc,Tc,fc,cc,kc,alpha_c)

im = double(imread(phyImg));
G = fspecial('gaussian', [5 5], 2);
% for I=1:1
    im = imfilter(im,G);
% end

[my,mx] = meshgrid(-25:0.25:275-0.25, -25:0.25:325-0.25);% 构造物理点
my=fliplr(my);
px = reshape(mx,1200*1400,1);
py = reshape(my,1200*1400,1);
imorigin = [px,py,zeros(length(px),1)]';

    
%     eval(['omc=omc_' num2str(I) ';']);
%     eval(['Tc=Tc_' num2str(I) ';']);
    [repmap] = project_points2(imorigin,omc,Tc,fc,cc,kc,alpha_c); % 物理点投影到像面  转为像面坐标
    repmap = repmap';
    % scatter(repmap(:,1),repmap(:,2))
    dx = reshape(repmap(:,1),1400,1200);
    dy = reshape(repmap(:,2),1400,1200);
    dx = fliplr(dx);
    dy = fliplr(dy);

    [mx,my] = meshgrid(1:1080, 1:1920);
    Vq = griddata(dx,dy,im,mx,my);
    
    Vq=mat2gray(Vq);
