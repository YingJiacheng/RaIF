function Veg_Map = GenerateVegMap(I_RGB,I_NIR,Sky_Map)

%% non Sky map
NonSky = 1- Sky_Map;


%% NDVI map
R=I_RGB(:,:,1);
NDVI=(imNorm((I_NIR-R)./(R+I_NIR+eps)));


%% Ratio map
G=I_RGB(:,:,2);
B=I_RGB(:,:,3);
ratio=imNorm(((G)./(R+G+B+eps)));


M = NDVI .* ratio .* NonSky;
alpha=20;
beta=0.2;
gamma=1;
Veg_Map=f1(M,alpha,beta,gamma);



end
