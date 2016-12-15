function err = crossvalidation(C, x, y)
% CROSSVALIDATION Computes mean-square prediction error for samples x and
% constant C with "leave-one-out" technique, using log-barrier function method.
% error = crossvalidation(C, x, y) for samples x associated with labels y.
load barrier.m;

err = [];
[d, n] = size(x);
for j=1:n
    if j == 1
         training = x(2:n, :);
         trainingl = y(2:n, :);
         testing = x(1, :);
         testingl = y(1, :);
    end
    if j == n
         training = x(1:(n-1), :);
         trainingl = y(1:(n-1), :);
         testing = x(n, :);
         testingl = y(n, :); 
    end
    if (j > 1 && j < n)
         training = x([1:(j-1) (j+1):n], :);
         trainingl = y([1:(j-1) (j+1):n], :);
         testing = x(j, :);
         testingl = y(j, :);
    end

    % Training : ai = C/2 satisfies the condition 0 <= a <= C
    a = barrier(training, trainingl, C, C/2*ones(n, 1));
    % Primal solution
    w = sum((a .* trainingl)'*training');
    % Confusion matrix
    if (w*testing == testingl)
        err = [err 0];
    else
        err = [err 1];
    end
    
end
err = sqrt(1/n*err);
