function [f, g, H] = logobj(A, b, x);
% LOGOBJ computes the value, gradient and hessian of log(b-Ax)
% [f, g, H] = logobj(A, b, x)
[m, n] = size(A);

d = A*x - b; 
D = diag(1./d);
f = - log(-d')*ones(m,1);
g = - A'*D*ones(m,1);
H = A'*D^2*A;
