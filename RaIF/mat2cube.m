function [A] = mat2cube(X, nl,nc)
%mat2im - converts a matrix to a 3D image

[p, n] = size(X);
A = reshape(X', nl, nc, p);