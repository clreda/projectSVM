function a = newton(K, y, C, ainit, t)
load svm_obj.m

% parameter
ALPHA = 0.01;%.1; 
BETA = 0.5;%.7;
NTTOL = power(1, -10); % stop iteration if lambda^2/2 < NTTOL
MAXITERS = 1000;% maximum number of iterations

a = ainit;

% Allows to plot the convergence
cv = [];
minimum = svm_obj(a, K, y, C, t);

for k=1:MAXITERS % Inner loop
        [val, g, H] = svm_obj(a, K, y, C, t);

        "being in kth step"
        k
        
        cv = [cv val];
        if (minimum > val)
             minimum = val;
        end
        
        %% Newton step and decrement
        v = -H\g; 
        lambda = g'*v; % lambda here is lambda ^ 2
        
        %% Perform backtracking line search along search direction
        s = 1;
        % First get strictly feasible point...
        while (min(a+s*v) < 0) || (max(a+s*v) > C)
            s = BETA*s;
        end 
        % search for the minimum
        while 1
            [nextval, nextg, nexth] = svm_obj(a+s*v, K, y, c, t);
            if nextval < (val + ALPHA*s*lambda)
                break;
            end;
            s = BETA*s;
        end
        
        %% Update a
        a = a+s*v;
        
        %% Stopping criteria
        if (abs(lambda/2) < NTTOL)
            break;
        end 
end

%% Print convergence
cv = cv .- minimum;
semilogy(1:MAXITERS, cv);
