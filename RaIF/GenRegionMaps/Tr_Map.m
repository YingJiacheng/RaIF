function [t] = Tr_Map(H)


[h, w, c] = size(H);

A = obtain_A(H);

[J,t] = obtain_J_t(H,A,[h,w,c]);

end

