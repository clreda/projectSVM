function [a, cv] = newton(K, y, C, ainit, t)
% NEWTON Implements Newton's method for optimization.
% a = newton(K, y, C, ainit, t) Returns Lagrange multiplier a for
% samples of labels y, kernel matrix K, constant C, initialization
% of Lagrange multiplier ainit (parameters for backtracking line
% search : ALPHA=0.01, BETA=0.5, tolerance 1e-10 (stops iteration
% if lambda^2/2 < 1e-10), maximum number of
% iterations 1000).
load svmobj.m;

% Parameters for backtracking line direction search
ALPHA=0.01;
BETA=0.5;
% Tolerance threshold
NTTOL=1e-10;
% Maximum number of iterations
MAXITERS=1000;

a = ainit;

% To plot the convergence
cv = [];
minimum = svmobj(a, K, y, C, t);

for k=1:MAXITERS
        [val, g, H] = svmobj(a, K, y, C, t);
        
        % To plot the convergence
        cv = [cv val];
        if (minimum > val)
             minimum = val;
        end
        
        % Newton step and decrement
        v = -H\g; 

        % lambda here is actually lambda^2
        lambda = g'*(-v);
        
        % Backtracking line search
        s = 1;
        % First get strictly feasible point
        while (min(a+s*v) < 0) || (max(a+s*v) > C)
            s = BETA*s;
        end 
        while 1
            [nextval, nextg, nexth] = svmobj(a+s*v, K, y, C, t);
            if nextval <= (val + ALPHA*s*lambda)
                break;
            end;
            s = BETA*s;
        end
        
        % Update a
        a = a+s*v;
        
        % Stopping criterium
        if (abs(lambda/2) < NTTOL)
            break;
        end 
        
end

if (k == MAXITERS)
    "La méthode de Newton n'a pas convergé.";
end

cv = cv .- minimum;
