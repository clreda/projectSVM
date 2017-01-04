function [alist, wlist, cv] = barrier(x, y, C, ainit)
% BARRIER Implements the barrier function method.
% a = BARRIER(x, y, C, ainit) x samples, y labels, C constant,
% ainit initialization of Lagrange multiplier a of dim 1 x m.
%load newton.m;

% Default values for parameters
tolerance=1e-10;
mu=10;

a = ainit;
n = size(a, 1);
% Kernel matrix
K = x'*x;

% Storing lists of values of a and w 
% to plot the duality gap
alist = [];
wlist = [];

t = 1;
nbiter = 0;
while (n/t > tolerance)
    % Update a and t
    [a, cv] = newton(K, y, C, ainit, t);
    alist = [alist a];
    wlist = [wlist ((a .* y')' * x')'];
    t = mu*t;
    nbiter = nbiter + 1;
end
