function y=f1(x,alpha,beta,gamma)
    y=1-1./(1+exp(-alpha*(beta-(x).^(gamma))));
end