function [f, gradf, hessf] = svmobj(a, K, y, C, t)
% SVMOBJ Returns value, gradient and hessian for objective function 
% t/2*a'*diag(y)*K*diag(y)*a - 1'*a + 1'*log(1./(a.*(C.-a)))
% [f, gradf, hessf] = svmobj(a, K, y, C, t) for labels y : n x 1, kernel
% matrix K : 1 x n, Lagrange multiplier a : n x 1, constant
% for classification error C : 1 x 1.

% n x n matrix
G = diag(y)*K*diag(y);
n = size(a, 1);
vec = ones(n, 1);

size(a)
size(G)

f = t/2*a*a'*G - vec'*(a - log(1./(a.*(C .- a))));

gradf = t*a*vec*G - n - C*vec'*(a.*(C .- a));

hessf = t*vec*vec*G - C*vec'*(C .- a + (C - 1).*a);

size(f)
size(gradf)
size(hessf)
