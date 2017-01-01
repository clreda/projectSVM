function x = accpm(A, b, xinit)
% ACCPM Finds dual solution by analytic center cutting-plane method
% Inequality: Ax <= b
% a = accpm(A, b, xinit)

% No dropping constraints (thus only useful for small instances)

load findacenter.m;
load computeobj.m;

%m is the number of inequalities
m = 1;
NTTOL = 1e-10;
[u, g, H] = computeobj(A, b, xinit);
l = u - m*sqrt(g'*(H\g));

while (1)
    x = findacenter(A, b); % find an analytic center using newton method
    [v, g, H] = computeobj(A, b, x);% calculate value, subgradient and hessian
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
