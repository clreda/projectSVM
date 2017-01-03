function [f, g, H] = computeobj(w, z, C);
% COMPUTEOBJ returns the value, gradient and hessian of ||w||^2 / 2
% + C1TZ
% [f, g, H] = computeobj(w, z, C)
% w = [ndim+1 x 1]
% z = [nsample x 1]
% C = error tolerance

%TODO COMPUTEOBJ

nsamples = size(z,1);
m = size(w,1);

%d = A*x - b; D = diag(1./d);
%f = w'*w/2 + C*ones(1,n)*z;
%g = - A'*D*ones(m,1);
%H = A'*D^2*A;

f = w'*w/2 + C*ones(1,nsamples)*z;
g = [w ; C*ones(nsamples,1)];
H = [eye(m) zeros(m,nsamples); zeros(nsamples,nsamples+m)];
