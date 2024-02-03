function [a,b] = find_weight_linear_coeff(X, Y, W,bias)

if bias == 1
sW = sum(W);
sWX = sum(W.*X); 
sWY = sum(W.*Y);
 sWXY = sum(W.*X.*Y);
 sWX2 = sum(W.*X.^2);
 
 a = (sW*sWXY-sWX*sWY)/(sW*sWX2-sWX*sWX);
 b = (sWY-a*sWX)/sW;
end
if bias == 0 
    sWXY = sum(W.*X.*Y);
    sWX2 = sum(W.*X.^2);
    a = sWXY/sWX2;
    b = 0;
end

if bias == 'r'
    max_sumw = 0;
    thre = 0.01;
    iter = 4000;
    idx_ls = randperm(numel(X),iter);
    for i = 1:iter
        idx = idx_ls(i);     
        samplex = X(idx);
        sampley = Y(idx);
        a = (sampley)/(samplex);
        b = 0;
        Y_linear = a * X;
        index = find((abs(Y_linear - Y))<=thre);
        sumw = sum(W(index));
        if sumw>max_sumw
            a_opt = a;
            b_opt = b;
            max_sumw = sumw;
        end
    end
    
    a = a_opt;
    b = b_opt;
end


end
        