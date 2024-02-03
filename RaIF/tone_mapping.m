function I_RGB_new = tone_mapping(I_RGB_est)

    xm = max(I_RGB_est(:));
    if xm <= 1+eps
        I_RGB_new = I_RGB_est;
        return
    end
    n = 0.5;
    
        I_RGB_new = I_RGB_est;
        syms b
        equ = (n-1)/(n+b) ==  log((n+b)/(xm+b));
        b = vpasolve(equ,b);
        b = double(b);
        a = n+b;
        c = n - a*log(n+b);

        I_RGB_new(I_RGB_new>n) = a*log(I_RGB_new(I_RGB_new>n)+b) +c;


    
   
end
