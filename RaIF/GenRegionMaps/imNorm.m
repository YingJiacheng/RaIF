function J=imNorm(I)
J=(I-min(I(:)))/(max(I(:))-min(I(:)));