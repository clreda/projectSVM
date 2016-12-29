function a = accpm(x, y, C, ainit)
% ACCPM Finds dual solution by analytic center cutting-plane method
% a = accpm(x, y, C, ainit)

% No dropping constraints (thus only useful for small instances)

load findacenter.m;
load computeobj.m;

m %number of inequalities

NTTOL=1e-10;
a = ainit;
[u, g, H] = computeobj(x, y, C, a);
l = u - m*sqrt(g'*(H\g));

while (1)
    a = findacenter(x, y, C);
    [v, g, H] = computeobj(x, y, C, a);
    u = min(u, v);
    l = max(l, v - m*sqrt(g'*(H\g)))
    % add inequality to polyhedron
    m = m + 1;
    % Stopping criterium
    if (u-l < NTTOL)
        break;
    end 
end
