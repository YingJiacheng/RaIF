function [J,t] = obtain_J_t(H,A,sz)
    h=sz(1);
    w=sz(2);
    c=sz(3);
% normalized hazy image H_n
    H_n = zeros(h,w,c);
    for i = 1:c
        H_n(:,:,i) = H(:,:,i)/A(i);
    end
    % the intensity of H_n
    I_H_n = (H_n(:,:,1)+H_n(:,:,2)+H_n(:,:,3)) / 3;
    % saturation of H_n
    me = unifrnd(0.00001,0.00002);
    S_H_n = zeros(h,w);

    S_H_n = 1 - min(min(H_n(:,:,1),H_n(:,:,2)),H_n(:,:,3))./(I_H_n+me);

    % saturation of J_n
    S_J_n = zeros(h,w);

%             if S_H_n(i,j) <= 0.5
%                 S_J_n(i,j) = 0.5 * (1 - (1-S_H_n(i,j)/0.5)^2.5);
%             else
%                 S_J_n(i,j) = 0.5 + 0.5 * ((S_H_n(i,j)-0.5)/0.5)^2;
%             end
            S_J_n = S_H_n .* (2 - S_H_n);
%             S_J_n(i,j) = (S_H_n(i,j)^(1/0.2) + (1-(1-S_H_n(i,j))^(1/0.2))) / 2;

    % t
    t = zeros(h,w);
    t = 1 - I_H_n .* (1 - S_H_n./S_J_n);
    t = max(min(t,1),me);
%     ratio = min(t(:));
%     t2 = t.^(3*(1-t));
%     t2 = t2.*ratio./min(t2(:));
%     t3 = (t2+t)/2;
%     t3 = min(t3,1);
    % J
    J = zeros(h,w,c);
            J(:,:,1) = (H(:,:,1) - A(1)) ./  t + A(1);
            J(:,:,2) = (H(:,:,2) - A(2)) ./  t + A(2);
            J(:,:,3) = (H(:,:,3) - A(3)) ./  t + A(3);
