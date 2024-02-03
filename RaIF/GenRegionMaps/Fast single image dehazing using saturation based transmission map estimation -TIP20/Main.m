clear all
rgb_name = 'E:\ivlab\YJC_materials\datasets\haze_image\# O-HAZY NTIRE 2018\hazy\11_outdoor_hazy.jpg';
%gt_name = 'E:\ivlab\YJC_materials\datasets\dataset\# O-HAZY NTIRE 2018\GT\11_outdoor_GT.jpg';
%Igt = double(imread(gt_name)) / 255; 
H = double(imread(rgb_name)) / 255;
%Igt= imresize(Igt,0.25);
H= imresize(H,0.25);

[h, w, c] = size(H);
img_size = h * w;

H_wb = white_balance_haze_image(H);
A = obtain_A(H);
A_wb = obtain_A(H_wb);

Delta_A = max(A)-min(A);
Delta_A_wb = max(A_wb)-min(A_wb);

% 不进行白平衡
if Delta_A <= Delta_A_wb
    flag=1
    [J,t] = obtain_J_t(H,A,[h,w,c]);
    
% 进行白平衡 
elseif Delta_A > Delta_A_wb
    [J_white,t] = obtain_J_t(H,A_wb,[h,w,c]);
    J = white_balance_haze_image(J_white);
end

 %J_out = tone_mapping(J,t);

% 结果输出
figure,
imshow(H);
figure,
imshow(t);
figure,
imshow(J);
% imwrite(J,'./output_saturation/005.png');
