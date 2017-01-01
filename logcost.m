function [f,g,H] = logobj(A,b,x);
% LOGCOST computes the value, gradient and hessian of log(b-Ax)
[m,n] = size(A);

d = A*x - b; D = diag(1./d);
f = - log(-d')*ones(m,1);
g = - A'*D*ones(m,1);
H = A'*D^2*A;
