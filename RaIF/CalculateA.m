function [A] = CalculateA(Z_RGB,Z_H)

[M,N,~,~]=size(Z_RGB);
A=zeros(M,N,2,2);

for i=1:M
    for j=1:N
        z_rgb(:,:)=Z_RGB(i,j,:,:);
        z_h(:,:)=Z_H(i,j,:,:);
        
        [H1,diag1]=eig(z_rgb);
        [H2,diag2]=eig(z_h);
        diag1(diag1<0) =0;
        diag2(diag2<0) =0;
        P=H1*((pinv(diag1)).^(0.5))*H1;
        Q=H2*((diag2).^(0.5))*H2;
        
        P2=H1*((diag1).^(0.5))*H1;
        [D,S,E]=svd(P2*Q');
        O=D*E';
        A(i,j,:,:)=P*O*Q;
    end
end
        



end
