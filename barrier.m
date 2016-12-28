function [alist, wlist] = barrier(x, y, C, ainit, tolerance=1e-10, mu=10)
% BARRIER Implements the barrier function method.
% a = BARRIER(x, y, C, ainit) x samples, y labels, C constant,
% ainit initialization of Lagrange multiplier a of dim 1 x m.
% a = BARRIER(x, y, C, ainit, tolerance) with tolerance.
% a = BARRIER(x, y, C, ainit, tolerance, mu) with mu.
load newton.m;
load dualitygap.m;

a = ainit;
n = size(a, 1);
% Kernel matrix
K = x'*x;

alist = [];
wlist = [];

t = 1;
nbiter = 0;
while (n/t > tolerance)
    % Update a and t
    [a, cv] = newton(K, y, C, ainit, t);
    alist = [alist a];
    wlist = [wlist ((a .* y')' * x')'];
    size(wlist)
    break
    t = mu*t;
    nbiter += 1;
    %plot(1:size(cv, 2), cv);
    %hold on;
end

%semilogy(1:size(cv, 2), cv);
"Number of iterations", nbiter
