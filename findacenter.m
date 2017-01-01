function x = findacenter(A, b)
% FINDACENTER Implements Newton's method for optimization -log(b_i - a_i x).
% x = findacenter(A, b)

% Parameters for backtracking line direction search
ALPHA = 0.01;
BETA = 0.5;
% Tolerance threshold
NTTOL = 1e-10;
% Maximum number of iterations
MAXITERS = 1000;

% To plot the convergence
%cv = [];
%minimum = svmobj(a, K, y, C, t);

for k=1:MAXITERS
    % Compute value, (sub)gradient and hessian
        [val, g, H] = computeobj(A, b, x);
        
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
        t = 1;
        while 1
            [nextval, nextg, nexth] = computeobj(A, b, x + t*v);
            if nextval <= (val + ALPHA*t*lambda)
                break;
            end;
            t = BETA*t;
        end
        
        % Update x
        x = x + t*v;
        
        % Stopping criterium
        if (abs(lambda/2) < NTTOL)
            break;
        end 
        
end

