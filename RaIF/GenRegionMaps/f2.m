function y=f2(x,alpha,beta,gamma)
    y=1./(1+exp(-alpha*(1-(1-x).^(1/gamma)-beta)));
end