function [f, g, H] = computeobj(w, z, C);
% COMPUTEOBJ returns the value, gradient and hessian of ||w||^2 / 2
% + C 1^Tz
% [f, g, H] = computeobj(w, z, C)
% w = [ndim+1 x 1]
% z = [nsample x 1]
% C = error tolerance

n = size(z,1);
m = size(w,1);

f = w'*w/2 + C*ones(1, n)*z;
g = [w ; C*ones(n, 1)];
H = [eye(m) zeros(m, n); zeros(n, n+m)];
