function [Pred_Sky,Sky_overexposed] = OverSkyRecovery(I_RGB,I_NIR,Sky_Map)

    overexposed_part = sum(I_RGB >=1, 3) >= 1;
    Sky_overexposed = (Sky_Map.*overexposed_part)>0;
    Sky_underexposed = (Sky_Map.*(~overexposed_part))>0;


    R = I_RGB(:,:,1);
    G = I_RGB(:,:,2);
    B = I_RGB(:,:,3);
    N = I_NIR;


    R_list = R(Sky_underexposed);
    G_list = G(Sky_underexposed);
    B_list = B(Sky_underexposed);
    N_list = N(Sky_underexposed);
    weight_list = (Sky_Map(Sky_underexposed)).^3;

    if sum(sum(Sky_Map(Sky_underexposed)))/sum(sum(Sky_Map)) < 0.05
        a = [1.4749,1.5779,1.9011];
        alpha = 0.7;
    else
        [a,alpha] = find_gain_gamma(N_list,R_list,G_list,B_list,weight_list);
    end

    Pred_Sky = cat(3,a(1)*I_NIR.^alpha,a(2)*I_NIR.^alpha,a(3)*I_NIR.^alpha);
    
end
