function [f,g,H] = computeobj(A,b,x);
[m,n] = size(A);

d = A*x - b; D = diag(1./d);
f = - log(-d')*ones(m,1);
g = - A'*D*ones(m,1);
H = A'*D^2*A;
