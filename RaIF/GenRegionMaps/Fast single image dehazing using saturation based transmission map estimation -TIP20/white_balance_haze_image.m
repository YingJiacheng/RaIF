%% Obtain white balanced hazy image H_wb using(21).

function H_wb = white_balance_haze_image(H)
    [h, w, c] = size(H);
    H_wb = zeros(h,w,c);
    img_size = h * w;
    mean_r = mean(mean(H(:,:,1)));
    mean_g = mean(mean(H(:,:,2)));
    mean_b = mean(mean(H(:,:,3)));
    H_wb(:,:,1) = min((mean_g / mean_r) * H(:,:,1),1);
    H_wb(:,:,2) =  H(:,:,2);
    H_wb(:,:,3) = min((mean_g / mean_b) * H(:,:,3),1);
end


    