function [x vecx] = findacenter(A, b,xinit)
% FINDACENTER Implements Newton's method for optimization -log(b_i - a_i x).
% x = findacenter(A, b)

% Parameters for backtracking line direction search
ALPHA = .1; BETA = .7;
% Tolerance threshold
NTTOL = 1e-10;
% Maximum number of iterations
MAXITERS = 2000;

x = xinit;
vecx = []
for k=1:MAXITERS % Inner loop
        [val,g,H] = logobj(A,b,x);
        vecx = [vecx val];
        v = -H\g; % Newton step
        lambda = -g'*v; % Newton decrement
        % Perform backtracking line search along search direction
        s = 1;
        while (min([b - A*(x+s*v)]) < 0)
        s = BETA*s;
        end % first get feasible point ... then search minimum
        
        val2 = logobj(A,b,x+s*v);
        while val2 > val + ALPHA*s*lambda
        s = BETA*s;
        val2 = logobj(A,b,x+s*v);
        end
        
        if isnan(val2)
            break;
        end;
        
        x = x+s*v;
    % stopping criteria
    if (abs(lambda/2) < NTTOL) % decrement smaller than NTTOL?
       break;
    end
end

