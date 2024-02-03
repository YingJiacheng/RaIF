function  [x_temp,y_temp,value_temp]=psf_filter(i,j,M,N,psf)

[h,w]=size(psf);
y_temp=((j-1)*M+i)*ones(1,h*w);

istart=i-floor((h-1)/2);
iend=i+ceil((h-1)/2);
jstart=j-floor((w-1)/2);
jend=j+ceil((w-1)/2);

[y,x]=meshgrid(jstart:jend,istart:iend);

%%%imfilter circular 的写法
% y=mod(y-1,N);
% x=mod(x,M);
% x=x+(x==0)*M;
% x_mat=y*M+x;
% x_temp=x_mat(:)';
%         
% value_temp=psf(:)';

%%%imfilter replace 的写法
y=min(max(y-1,0),N-1);
x=min(max(x,1),M);
x_mat=y*M+x;
x_temp=x_mat(:)';

value_temp=psf(:)';


end

