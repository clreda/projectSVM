function a = newton(K, y, C, ainit, t, ALPHA=0.01, BETA=0.5, NTTOL=1e-10, MAXITERS=1000)
% NEWTON Implements Newton's method for optimization.
% a = newton(K, y, C, ainit, t) Returns Lagrange multiplier a for
% samples of labels y, kernel matrix K, constant C, initialization
% of Lagrange multiplier ainit (parameters for backtracking line
% search : ALPHA=0.01, BETA=0.5, tolerance 1e-10 (stops iteration
% if lambda^2/2 < 1e-10), maximum number of
% iterations 1000).
% a = newton(K, y, C, ainit, t, ALPHA, BETA) with parameters ALPHA
% and BETA for backtracking line search.
% a = newton(K, y, C, ainit, t, ALPHA, BETA, NTTOL) with parameters ALPHA
% and BETA for backtracking line search, and NTTOL for tolerance.
% a = newton(K, y, C, ainit, t, ALPHA, BETA, NTTOL, MAXITERS) with
% parameters ALPHA and BETA for backtracking line search, NTTOL for tolerance and
% maxiters for maximum number of iterations.
load svmobj.m;

a = ainit;

% To plot the convergence
cv = [];
[minimum, _, _] = svmobj(a, K, y, C, t);

for k=1:MAXITERS
        [val, g, H] = svmobj(a, K, y, C, t);

        "being in kth step"
        k
        
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
            if nextval < (val + ALPHA*s*lambda)
                break;
            end;
            s = BETA*s;
        end
        
        % Update a
        a = a+s*v;
        
        % Stopping criteria
        if (abs(lambda/2) < NTTOL)
            break;
        end 
        
end

if (k == MAXITERS)
    "La méthode de Newton n'a pas convergé."
end

% Plots convergence
cv = cv .- minimum;
semilogy(1:k, cv);
