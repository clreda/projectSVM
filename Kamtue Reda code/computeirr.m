function [isirrel, irr] = computeirr(A, b, x, H, i)
% COMPUTEIRR Computes irrelevance measure for constraint i
% of polyhedron Ax <= b
% [isirrel, irr] = computeirr(A, b, x, H, i) H hessian, isirrel is 
% a boolean set to true iff ith constraint of polyhedron is irrelevant

% Number of inequalities
m = size(A, 1);

% Compute measure
irr = (b(i, 1) - A(i, :)'*x)/sqrt(A(i, :)'*inv(H)*A(i, :));
% Is the constraint irrelevant?
isirrel = (irr >= m);
