function a = newtoncoord(K, y, C, ainit, i)
% NEWTONCOORD Implements Newton's method for minimization along one
% coordinate.
% a = newtoncoord(K, y, C, ainit, i) Returns Lagrange multiplier a for
% samples of labels y, kernel matrix K, constant C, initialization
% of Lagrange multiplier ainit respect to ith coordinate
%load svmobj.m;

% Tolerance threshold
NTTOL=1e-10;
% Maximum number of iterations
MAXITERS=1000;

a = ainit;

% To plot the convergence
cv = [];
minimum = svmobj(a, K, y, C, 1);

for k=1:MAXITERS
        [val, g, H] = svmobj(a, K, y, C, 1);
        % df/d(a_i)
        g = g(i, 1);
        % d^2f/d^2(a_i)
        H = H(i, i);
        
        % To plot the convergence
        cv = [cv val];
        if (minimum > val)
             minimum = val;
        end
        
        % Newton step and decrement
        v = -H\g; 

        % lambda here is actually lambda^2
        lambda = g'*(-v);
        
        % Update a ONLY on the ith coordinate 
        a(i, 1) = a(i, 1) + v;
        
        % Stopping criterium
        if (abs(lambda/2) < NTTOL)
            break;
        end 
        
end

if (k == MAXITERS)
    "La méthode de Newton n'a pas convergé.";
end

cv = cv .- minimum;
%semilogy(1:k, cv)
