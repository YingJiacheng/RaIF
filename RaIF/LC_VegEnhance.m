function Final_Result = LC_VegEnhance(Fused_RGB,Veg_Map)

    V = sum(Fused_RGB,3)/3;
    r = Fused_RGB(:,:,1)./V;
    g = Fused_RGB(:,:,2)./V;
    b = Fused_RGB(:,:,3)./V;
    V = tone_mapping(V);
    beta = 0.3;
    V_new = V + V.*Veg_Map*beta;
    
    Final_Result = Fused_RGB;
    Final_Result(:,:,1) = V_new.*r;
    Final_Result(:,:,2) = V_new.*g;
    Final_Result(:,:,3) = V_new.*b;
end