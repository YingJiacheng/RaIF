function Sky_Map = GenerateSkyMap(I_RGB,I_NIR)

[height,width,~]=size(I_RGB);
I_gray=double(rgb2gray(I_RGB));

%% Transmission map
trmap = Tr_Map(I_RGB);
tr = 1 - imNorm(trmap);

%% Entropy map
radius = ceil(0.005*height);
En_vis=entropyfilt(I_gray,strel('disk',radius).Neighborhood);
En_nir=entropyfilt(I_NIR,strel('disk',radius).Neighborhood);
r=32;
ep=0.000001;
EnG_vis=1-imNorm(guidedfilter(I_gray,En_vis,r,ep)).^2;
EnG_nir=1-imNorm(guidedfilter(I_NIR,En_nir,r,ep)).^2;
EnG = imNorm(EnG_vis.*EnG_nir);

%% Height map
hmap=zeros(size(I_gray));
for k=1:height
    hmap(k,1:width)=exp(-(k/height/1.2)^2);
end


ret=tr.*EnG.*hmap;
alpha=20;
beta = 0.4;
gamma=1;
Sky_Map=f1(ret,alpha,beta,gamma);
end