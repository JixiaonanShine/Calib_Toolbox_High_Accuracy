D=load('test.txt');
D=D(:,3);
[x,y]=meshgrid(1:480,1:640);
K=reshape(D,640,480);
K=-K;
K(find(K<-800))=0;
surf(K);