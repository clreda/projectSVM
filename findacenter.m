function x = findacenter(A, b)
% FINDACENTER Implements Newton's method for optimization -log(b_i - a_i x).
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

% To plot the convergence
%cv = [];
%minimum = svmobj(a, K, y, C, t);

for k=1:MAXITERS
        [val, g, H] = logobj(A,b,x);
        
        % To plot the convergence
        %cv = [cv val];
        %if (minimum > val)
        %     minimum = val;
        %end
        
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
            [nextval, nextg, nexth] = logobj(A,b,x+s*v);
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

