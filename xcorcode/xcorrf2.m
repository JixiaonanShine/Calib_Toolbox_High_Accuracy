%> @file xcorrf2.m
%> @brief Two-dimensional cross-correlation using Fourier transforms.
%==================================================================== 
%> XCORRF2(A,B) computes the crosscorrelation of matrices A and B.@n
%> XCORRF2(A) is the autocorrelation function.@n
%> This routine is functionally equivalent to xcorr2 but usually faster.
%> @author R. Johnson
%> @param a,b 要计算相关的图
%> @param pad 要不要扩展 @b default='yes'
%> @param type 选择相关算法
%> - @c phase 相位 @b default
%> - @c zeropad 对应INSIGHT里的zeropad
%> - @c normal 原来的相关.最普通的一种
%> @section Example
%> @code
%> im=double(imread('tire.tif'));
%> im1=im(100-32+1:100+32,100-32+1:100+32);
%> im2=im(100-32:100+32-1,100-32:100+32-1);
%> c=xcorrf2(im1,im2,'yes','phase');
%> surf(c)
%> @endcode
function c = xcorrf2(a,b,pad,type)

  if nargin<3
    pad='yes';
  end
  
  if ~exist('type','var')
      type='phase';
  end
  
  [ma,na] = size(a);
  if nargin == 1
    %       for autocorrelation
    b = a;
  end
  [mb,nb] = size(b);
  %       make reverse conjugate of one array
  b = conj(b(mb:-1:1,nb:-1:1));
  
  if strcmp(pad,'yes');
    %       use power of 2 transform lengths
    mf = 2^nextpow2(ma+mb);
    nf = 2^nextpow2(na+nb);
    
%     a=[a,fliplr(a);flipud(a),flipud(fliplr(a))];
%     b=[b,fliplr(b);flipud(b),flipud(fliplr(b))];
    at = fft2(b,mf,nf);
    bt = fft2(a,mf,nf);

%     at = fft2(b,mf,nf);
%     bt = fft2(a,mf,nf);
  elseif strcmp(pad,'no');
    at = fft2(b);
    bt = fft2(a);
  else
    disp('Wrong input to XCORRF2'); return
  end
  
  
  %multiply transforms then inverse transform
  switch (type)
      case 'phase'
          %%% phrase correlation
          x=at.*bt;
          k=(abs(x));k(find(k==0))=1;
          x=real(x)./k+i*imag(x)./k;
      case 'zeropad'
          %%% zero pad
          x=at.*bt;
          mask=ones(mf);
          N=fix(ma/2);
          mask(1:N,1:N)=0;mask(mf-N+1:mf,mf-N+1:mf)=0;mask(mf-N+1:mf,1:N)=0;mask(1:N,mf-N+1:mf)=0;
          x=x.*mask;
      case 'normal'
          x=at.*bt;
      case 'test'
          %%% phrase correlation
          x=at.*bt;
          k=(abs(x));k(find(k==0))=1;
          x=real(x)./k+i*imag(x)./k;
  end
  %%% ifft
  c = ifft2(x);
  %       make real output for real input
  if ~any(any(imag(a))) & ~any(any(imag(b)))
    c = real(c);
  end
  %  trim to standard size
  
  if strcmp(pad,'yes');
    c(ma+mb:mf,:) = [];
    c(:,na+nb:nf) = [];
  elseif strcmp(pad,'no');
    c=fftshift(c(1:end-1,1:end-1));
    
%    c(ma+mb:mf,:) = [];
%    c(:,na+nb:nf) = [];
  end



