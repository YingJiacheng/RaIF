%% obtain A from H

function A = obtain_A(H)

    [h, w, ~] = size(H);
    img_size = h * w;
    win_size = 15;
    % 计算暗通道图像
    win_dark_temp = zeros(h,w);
    for j = 1:w
        for i = 1:h
            win_dark_temp(i,j) = min(H(i,j,:));
        end
    end
    win_dark = minfilt2(win_dark_temp, [win_size,win_size]);
 
    % 计算大气亮度A
    dark_channel = win_dark;
    times = round(img_size * 0.001);
    A = zeros(1,3);
    dark_channel_ls = dark_channel(:);
    [V,index] = sort(dark_channel_ls,'descend');
    index = index(1:times);
    R = H(:,:,1);R = R(:);
    G = H(:,:,2);G = G(:);
    B = H(:,:,3);B = B(:); 
    R = R(index);G = G(index);B = B(index);
    V_R = sort(R); V_G = sort(G) ; V_B = sort(B);
    A(1) = V_R(floor(times/2));
    A(2) = V_G(floor(times/2));
    A(3) = V_B(floor(times/2));
    

    
end