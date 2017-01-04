function x = accpm(C, A, b, xinit)
% ACCPM Finds dual solution by analytic center cutting-plane method
% Inequality: Ax <= b
% a = accpm(A, b, xinit)
load findacenter.m;
load logobj.m;
load computeirr.m;

% Dropping constraints strategies:
% drop = 0 : drop all constraints having n_i >= m
% drop = 1 : drop constraints in order of relevance, having constant
% number of constraints 3n
% drop = 2 : no constraint dropping
%drop = 0;
%drop = 1;
drop = 2;

% m is the number of inequalities in polytop
m = size(A, 1);

% n is the number of samples
% d is the dimension of the points
[n, d] = size(A);

% Tolerance threshold
NTTOL = 1e-10;

x = xinit;

w = x(1:d, 1);
z = x((d+1):end, 1);

[u, g, H] = computeobj(w, z, C);
l = u - m*sqrt(g'*(H\g));

for k=1:1000
    
    % Find an analytic center using Newton's method
    x = findacenter(A, b, x);
    [_, _, H] = logobj(A, b, x); % hessian of barrier at x
    
    % Compute value, subgradient of objective function
    w = x(1:d, 1);
    z = x((d+1):end, 1);
    [v, g, _] = computeobj(w, z, C);
    
    u = min(u, v);
    l = max(l, v - m*sqrt(g'*(H\g)));
    
    % Add an inequality gTz <= gTx* to polyhedron
    m = m + 1;
    A = [A ; g'];
    b = [b ; g'*x];
    
    % Dropping constraints
    if (drop == 0)
        for i=1:m
            if computeirr(A, b, x, H, i)
                A = A(setxor(1:m, i), :);
                b = b(setxor(1:m, i), :);
                m = m - 1;
            end
        end
    else
        i = 1;
        while (and(m > 3*n, i < m+1))
            if computeirr(A, b, x, H, i)
                A = A(setxor(1:m, i), :);
                b = b(setxor(1:m, i), :);
                m = m - 1;
            end
            i = i + 1;
        end
    end
    
    % Stopping criterium
    if (u-l < NTTOL)
        break;
    end 
end
