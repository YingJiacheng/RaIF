function r = optimize_r(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,V,g,method)
    Q1 = Pxr;
    Q2 = (3*V.*(1-g))*Dx-Pxb;
    Q3 = Pyr;
    Q4 = (3*V.*(1-g))*Dy-Pyb;
    
    S1 = 3*sparse(1:MN,1:MN,V,MN,MN)*Dx;
    S2 = S1;
    S3 = 3*sparse(1:MN,1:MN,V,MN,MN)*Dy;
    S4 = S3;
    
    b = (Q1*S1'+Q2*S2'+Q3*S3'+Q4*S4'+lambda2*ro*M3+lambda2*rc*M4)';
    A = (S1*S1'+S2*S2'+S3*S3'+S4*S4'+lambda2*M3+lambda2*M4)';
   
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
    r = x';
    
    %r = (Q1*S1'+Q2*S2'+Q3*S3'+Q4*S4'+lambda1*ro*M3+lambda2*rc*M4)/(S1*S1'+S2*S2'+S3*S3'+S4*S4'+lambda1*M3+lambda2*M4);
end
    
