function Fused_Grad = GradFusion(I_RGB,I_NIR,Pred_Sky,Sky_overexposed)

    [M,N]=size(I_NIR);
    I_H  = zeros(M,N,4);
    I_H(:,:,1) = I_NIR;
    I_H(:,:,2:4) = I_RGB;

    Grd_RGB = GenGradient(I_RGB);
    Grd_H = GenGradient(I_H);
    Z_RGB = CalculateZ(Grd_RGB);
    Z_H = CalculateZ(Grd_H);
    A = CalculateA(Z_RGB,Z_H);
    
    Fused_Grad = zeros(M,N,3,2);
    for i=1:M
        for j=1:N
            grd(:,:) = Grd_RGB(i,j,:,:);
            a_mat(:,:) = A(i,j,:,:);
            Fused_Grad(i,j,:,:) = grd*a_mat;
        end
    end
    
    Pred_Sky_Grd = GenGradient(Pred_Sky); 
     for i=1:3
        for j=1:2
            Fused_Grad(:,:,i,j) = Fused_Grad(:,:,i,j).*(~Sky_overexposed) + Sky_overexposed.*Pred_Sky_Grd(:,:,i,j);
        end
     end
     
end