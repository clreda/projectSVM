function x = accpm(C, A, b, xinit)
% ACCPM Finds dual solution by analytic center cutting-plane method
% Inequality: Ax <= b
% a = accpm(C, A, b, xinit)

% No dropping constraints (thus only useful for small instances)

load findacenter.m;
load computeobj.m;

% m is the number of inequalities in polytop
m = 1;
% Initialization of w, z
w = ;
z = ;
% Tolerance threshold
NTTOL = 1e-10;
[u, g, H] = computeobj(w, z, C);
l = u - m*sqrt(g'*(H\g));

while (1)
    % Find an analytic center using Newton's method
    x = findacenter(A, b);
    % calculate value, subgradient and hessian
    [v, g, H] = computeobj(w, z, C);
    u = min(u, v);
    l = max(l, v - m*sqrt(g'*(H\g)));
    % add an inequality gTz <= gTx* to polyhedron
    m = m + 1;
    A = [A ; g'];
    b = [b ; g'*x];
    % Stopping criterium
    if (u-l < NTTOL)
        break;
    end 
end
