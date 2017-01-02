function [isirrel, irr] = computeirr(A, b, x, H, i)
% COMPUTEIRR Computes irrelevance measure for constraint i
% of polytop Ax <= b
% [isirrel, irr] = computeirr(A, b, x, H, i) H hessian, isirrel is 
% a boolean set to true iff ith constraint of polytop is irrelevant

% Number of inequalities
m = size(A, 1);

irr = (b(i, 1) - A(i, :)'*x)/sqrt(A(i, :)'*inv(H)*A(i, :));
isirrel = (irr >= m);