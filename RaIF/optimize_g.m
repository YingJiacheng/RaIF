function g = optimize_g(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,V,r,method);
    U1 = Pxg;
    U2 = (3*V.*(1-r))*Dx-Pxb;
    U3 = Pyg;
    U4 = (3*V.*(1-r))*Dy-Pyb;
    
    X1 = 3*sparse(1:MN,1:MN,V,MN,MN)*Dx;
    X2 = X1;
    X3 = 3*sparse(1:MN,1:MN,V,MN,MN)*Dy; 
    X4 = X3;
    
    b = (U1*X1'+U2*X2'+U3*X3'+U4*X4'+lambda2*go*M3+lambda2*gc*M4)';
    A = (X1*X1'+X2*X2'+X3*X3'+X4*X4'+lambda2*M3+lambda2*M4)';

    tol = 1e-5;
    maxiter = 1000;
    switch method,
    case 'divide', 
        x = A\b;      
    case 'pcg',    
        [x] = pcg(A,b,tol,maxiter);
    case 'lsqr',  
        x = lsqr(A,b,tol,maxiter);
    case 'minres', 
        x = minres(A,b,tol,maxiter);
    case 'symmlq', 
        x= symmlq(A,b,tol,maxiter);
    case 'bicg', 
        x= bicg(A,b,tol,maxiter);
    case 'bicgstab', 
        x = bicgstab(A,b,tol,maxiter);
    case 'bicgstabl',
        x = bicgstabl(A,b,tol,maxiter);
    case 'cgs',
        x = cgs(A,b,tol,maxiter);
    case 'gmres',
        x = gmres(A,b,3,tol,maxiter);
    case 'qmr',
        x = qmr(A,b,tol,maxiter);
    case 'tfqmr'
        x = tfqmr(A,b,tol,maxiter);
    end
    g = x';
    
    %g = (U1*X1'+U2*X2'+U3*X3'+U4*X4'+lambda1*go*M3+lambda2*gc*M4)/(X1*X1'+X2*X2'+X3*X3'+X4*X4'+lambda1*M3+lambda2*M4);
end

