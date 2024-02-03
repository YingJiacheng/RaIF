function [Z] = CalculateZ(Grd)

[M,N,L,~]=size(Grd);
Z=zeros(M,N,2,2);
for i=1:M
    for j=1:N
        grd(:,:)=Grd(i,j,:,:);
        Z(i,j,:,:)=grd'*grd;
    end
end



end

