function a = coorddescent(x, y, C, ainit)
% COORDDESCENT Implements coordinate descent.
% a = coorddescent(x, y, C, ainit) Returns the dual solution
% for data x, y, C constant, ainit initialization of dual vector. 
load newtoncoord.m;

a = ainit;
n = size(a, 1);
% Kernel matrix
K = x'*x;

for i=1:n
   % Minimizing function respect to ith coordinate
   a = newtoncoord(K, y, C, a, i);
end

