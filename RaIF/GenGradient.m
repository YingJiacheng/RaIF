function [Grd_img] = GenGradient(img)

dx=[-1  1];
dy=[-1 ; 1];

[M,N,L]=size(img);
Grd_img=zeros(M,N,L,2);
img_dx=imfilter(img,dx,'conv','circular','conv');
img_dy=imfilter(img,dy,'conv','circular','conv');

Grd_img(:,:,:,1)=img_dx;
Grd_img(:,:,:,2)=img_dy;


end

