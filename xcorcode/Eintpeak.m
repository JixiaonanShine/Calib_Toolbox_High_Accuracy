%> @file Eintpeak.m
%> @brief 9���ֵ�����㷨��
%==========================================
%> from paper(����paper ):@n 
%> Two-dimensional Gaussian regression for sub-pixel displacement
%> estimation in particle image velocimetry or particle position estimation
%> in particle tracking velocimetry ����㷨��д�� 
%>
%> <http://www.springerlink.com/content/mn61t750l122l733/ LINK>
%> @param x0,y0 ��ص�����
%> @param M �������,��ǰ��߷��9��
%> @param nsize ��ش��ڴ�С
%> @retval x,y peak�����ķ�ֵ
%> @sa intpeak
%> @ingroup randmaplist
%> @section Example
%> @code
%> Z = peaks(30);
%> surf(Z)
%> pos=find(Z==max(Z(:)));
%> [y,x]=ind2sub(size(Z),pos);
%> [x,y]=Eintpeak(x,y,Z(y-1:y+1,x-1:x+1),0);
%> @endcode
function [x,y]=Eintpeak(x0,y0,M,nsize)

c10=0;c01=0;c11=0;c20=0;c02=0;c00=0;
for I=-1:1
    for J=-1:1
        c10=c10+1/6*I.*log(M(I+2,J+2));
        c01=c01+1/6*J.*log(M(I+2,J+2));
        c11=c11+1/4*I.*J.*log(M(I+2,J+2));
%         if I~=0
        c20=c20+1/6*(3.*I.^2-2).*log(M(I+2,J+2));
%         end
%         if J~=0
        c02=c02+1/6*(3.*J.^2-2).*log(M(I+2,J+2));
%         end
        c00=c00+1/9*(5-3.*I.^2-3.*J.^2).*log(M(I+2,J+2));
    end
end

y=(c11*c01-2*c10*c02)/(4*c20*c02-c11^2);
x=(c11*c10-2*c01*c20)/(4*c20*c02-c11^2);

% [sum(M(:,1)-M(:,3)) ,sum(M(1,:)-M(3,:)),-x,-y]
x=x0+x;
y=y0+y;
x=x-nsize;
y=y-nsize;

