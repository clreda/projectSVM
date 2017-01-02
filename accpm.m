function x = accpm(A, b, xinit)
% ACCPM Finds dual solution by analytic center cutting-plane method
% Inequality: Ax <= b
% a = accpm(A, b, xinit)

% Dropping constraints strategies:
% drop = 0 : drop all constraints having n_i >= m
% drop = 1 : drop constraints in order of relevance, having constant
% number of constraints 3n
drop = 0;
%drop = 1;

load findacenter.m;
load logobj.m;
load computeirr.m;

% m is the number of inequalities in polytop
m = size(A, 1);
n = m;
% Tolerance threshold
NTTOL = 1e-10;
[u, g, H] = logobj(A, b, xinit);
l = u - m*sqrt(g'*(H\g));

while (1)
    % Find an analytic center using Newton's method
    x = findacenter(A, b);
    % calculate value, subgradient and hessian
    [v, g, H] = logobj(A, b, x);
    u = min(u, v);
    l = max(l, v - m*sqrt(g'*(H\g)));
    % add an inequality gTz <= gTx* to polyhedron
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
         i = 0;
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
