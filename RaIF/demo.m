clear all
clc
addpath(genpath('./GenRegionMaps/'));

rgb_path = './datasets/1_rgb.tiff';
nir_path = './datasets/1_nir.tiff';

I_RGB = im2double(imread(rgb_path));
I_NIR = im2double(imread(nir_path));

[Sky_Map, Veg_Map] = GenerateRegionMaps(I_RGB,I_NIR);

[Pred_Sky,Sky_overexposed] = OverSkyRecovery(I_RGB,I_NIR,Sky_Map);

Fused_Grad = GradFusion(I_RGB,I_NIR,Pred_Sky,Sky_overexposed);

Fused_RGB = OptimizeRGB(Fused_Grad,I_RGB, Pred_Sky, Sky_Map);

Final_Result = LC_VegEnhance(Fused_RGB,Veg_Map);

figure,imshow(Final_Result)
imwrite(Final_Result,'./datasets/1_fused.tiff');

