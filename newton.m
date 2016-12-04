function a = newton(K, y, C, ainit, t)

cv = [];
minimum = svm_obj(a, K, y, C, t);

% parameter
ALPHA = .1; BETA = .7;
NTTOL = 1e-10; % stop iteration if lambda^2/2 < NTTOL

a = ainit;

for k=1:MAXITERS % Inner loop
        [val,g,H] = svm_obj(a, K, y, C, t);

        cv = [cv val];
        if (minimum > val)
             minimum = val;
        end
        
        % Newton step and decrement
        v = -H\g; 
        lambda = g'*v; % lambda here is lambda ^ 2
        
        % Perform backtracking line search along search direction
        s = 1;
        
        % first get feasible point ..
        while (min(a+s*v) < 0) || (max(a+s*v) > C)
        s = BETA*s;
        end 
        
        % search for the minimum
        while 1
        [nextval,nextg,nexth] = svm_obj(a+s*v,K,y,c,t);
        if nextval < val + ALPHA*s*lambda
            break;
        end;
        s = BETA*s;
        end
        
        % update a
        a = a+s*v;
        
        % stopping criteria
        if (abs(lambda/2) < NTTOL)
            break;
        end 
end

% Print convergence
cv = cv .- minimum;
semilogy(1:MAXITERS, cv)
