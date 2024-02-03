function V = optimize_V(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,r,g,method)
   
    P1 = Pxr;
    P2 = Pxg;
    P3 = Pxb;
    P4 = Pyr;
    P5 = Pyg;
    P6 = Pyb;
    
    T1 = 3*sparse(1:MN,1:MN,r,MN,MN)*Dx;
    T2 = 3*sparse(1:MN,1:MN,g,MN,MN)*Dx;
    T3 = 3*sparse(1:MN,1:MN,(1-r-g),MN,MN)*Dx;
    T4 = 3*sparse(1:MN,1:MN,r,MN,MN)*Dy;
    T5 = 3*sparse(1:MN,1:MN,g,MN,MN)*Dy;
    T6 = 3*sparse(1:MN,1:MN,(1-r-g),MN,MN)*Dy;
    
    b = (P1*T1'+P2*T2'+P3*T3'+P4*T4'+P5*T5'+P6*T6'+lambda1*Vo*M1+lambda1*Vs*M2)';
    A = (T1*T1'+T2*T2'+T3*T3'+T4*T4'+T5*T5'+T6*T6'+lambda1*M1+lambda1*M2)';
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
    V = x';
    
    %V = (P1*T1'+P2*T2'+P3*T3'+P4*T4'+P5*T5'+P6*T6'+lambda1*Vo*M1+lambda2*Vs*M2)/(T1*T1'+T2*T2'+T3*T3'+T4*T4'+T5*T5'+T6*T6'+lambda1*M1+lambda2*M2);
end
    



