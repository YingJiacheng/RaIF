function [a, alpha] = find_gain_gamma(N,R,G,B,W)

    max_sumw = 0;
    thre = 0.03;
    for alpha_i = 0.5:0.1:2.2
        N_new = N.^alpha_i;
        [a_r,~] = find_weight_linear_coeff(N_new, R, W,0);
        [a_g,~] = find_weight_linear_coeff(N_new, G, W,0);
        [a_b,~] = find_weight_linear_coeff(N_new, B, W,0);
        
        index_r = find((abs(a_r.*N_new - R))<=thre);
        sumwr = sum(W(index_r));
        index_g = find((abs(a_g.*N_new - G))<=thre);
        sumwg = sum(W(index_g));
        index_b = find((abs(a_b.*N_new - B))<=thre);
        sumwb = sum(W(index_b));
        sumw = sumwr + sumwg + sumwb;
        if sumw > max_sumw
            max_sumw = sumw;
            alpha = alpha_i;
            a = [a_r,a_g,a_b];
        end
    end

end


