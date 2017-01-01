function [alist, wlist] = coorddescent(C, x, y, ainit)
% COORDDESCENT Implements coordinate descent.
% [alist, wlist] = coorddescent(C, x, y) Returns the dual solution alist(:, end)
% for data x, y, C constant. Returns the values of a, w respect to the number of
% iterations of Newton's method

[n, d] = size(x);
a = ainit;
% Tolerance threshold
NTTOL = 1e-5;
% Kernel matrix
K = x'*x;
alist = [];
wlist = [];

for i=1:d
   % Minimizing function respect to ith coordinate
   % We look for a_i, 0 <= a_i <= C such as a_i
   % minimizes f(a_1, a_2, ..., a_i, a_(i+1), ..., a_n)
   % = f_i(a_i)
   a = newtoncoord(K, y, C, a, i);
   alist = [alist a];
   wlist = [wlist ((a .* y')' * x')'];
end

