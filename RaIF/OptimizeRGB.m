function Fused_RGB = OptimizeRGB(Fused_Grad,I_RGB, Pred_Sky, Sky_Map)


Ro = I_RGB(:,:,1);
Go = I_RGB(:,:,2);
Bo = I_RGB(:,:,3);
Vo = (Ro+Go+Bo)/3;
ro = Ro./(Ro+Go+Bo+eps);
go = Go./(Ro+Go+Bo+eps);
Vo = cube2mat(Vo);
ro = cube2mat(ro);
go = cube2mat(go);
V = Vo;
r = ro;
g = go;
[M,N,L,~]=size(Fused_Grad);
MN=M*N;
Dx=cal_B(M,N,[1 -1]);
Dy=cal_B(M,N,[1; -1]);
overexposed_part = sum(I_RGB >=1, 3) >= 1;
M1 = sparse(1:MN,1:MN,1-overexposed_part.*Sky_Map,MN,MN);
M2 = sparse(1:MN,1:MN,overexposed_part.*Sky_Map,MN,MN);
M3 = M1;
M4 = M2;

Rc = cube2mat(Pred_Sky(:,:,1));
Gc = cube2mat(Pred_Sky(:,:,2));
Bc = cube2mat(Pred_Sky(:,:,3));
rc = Rc./(Rc+Gc+Bc);
gc = Gc./(Rc+Gc+Bc);
Vs = (Rc+Gc+Bc)/3;

Pxr = cube2mat(Fused_Grad(:,:,1,1));
Pxg = cube2mat(Fused_Grad(:,:,2,1));
Pxb = cube2mat(Fused_Grad(:,:,3,1));
Pyr = cube2mat(Fused_Grad(:,:,1,2));
Pyg = cube2mat(Fused_Grad(:,:,2,2));
Pyb = cube2mat(Fused_Grad(:,:,3,2));

lambda1 = 1;
lambda2 = 1;

method = 'divide';
for iter=1:2
    %%optimize V
    V = optimize_V(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,r,g,method);

    %%optimize r
    r = optimize_r(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,V,g,method);

    %%optimize g
    g = optimize_g(MN,Pxr,Pxg,Pxb,Pyr,Pyg,Pyb,M1,M2,M3,M4,lambda1,lambda2,Dx,Dy,Vo,Vs,ro,go,rc,gc,V,r,method);

    R = mat2cube(3.*V.*r,M,N);
    G = mat2cube(3.*V.*g,M,N);
    B = mat2cube(3.*V.*(1-r-g),M,N);

    Fused_RGB = cat(3,R,G,B);

end

end

