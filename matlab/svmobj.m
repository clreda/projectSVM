function [f, gradf, hessf] = svmobj(a, K, y, C, t)
% SVMOBJ Returns value, gradient and hessian for objective function 
% t/2*a'*diag(y)*K*diag(y)*a - 1'*a - 1'*log(a.*(C.-a))
% [f, gradf, hessf] = svmobj(a, K, y, C, t) for labels y : n x 1, kernel
% K : [n x n] kernel matrix n = # training data
% Lagrange multiplier a : n x 1, constant
% y = [n x 1] output vector for training data
% for classification error C : 1 x 1.

% n x n matrix
%G = diag(y)*K*diag(y)
G = K .* (y * y'); 
n = size(a, 1);
vec = ones(n, 1);

f = t/2*a'*G*a - vec'*(a + log(a.*(C - a)));

gradf = t/2*((G + G')*a) - vec - (1./a - (C - 1)./(C - a));

% element-wise multiplication
asqr = a.*a;
acsqr = (C - a).*(C - a);

hessf = t/2*(G+G') + diag(1./asqr + 1./acsqr);
%hessf = t/2*(G+G') - ((C-1)./acsqr .- 1./asqr);
