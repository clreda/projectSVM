function error = crossvalidation(C, x, y)
% CROSSVALIDATION Computes mean-square prediction error for samples x and
% constant C with "leave-one-out" technique, using log-barrier function method.
% error = crossvalidation(C, x, y) for samples x associated with labels y.
load barrier.m;

error = [];
[d, n] = size(x);
for j=1:n
    training = x([1:(j-1) (j+1):n], :);
    trainingl = y([1:(j-1) (j+1):n], :);
    testing = x(j, :);
    testingl = y(j, :);

    % Training : ai = C/2 satisfies the condition 0 <= a <= C
    a = barrier(training, trainingl, C, C/2*ones(n, 1));
    % Primal solution
    w = sum((a .* trainingl)'*training);
    % Confusion matrix
    if ((w*testing)(1, 1) = testingl)
        error = [error 0];
    else
        error = [error 1];
    end
    
end
error = sqrt(1/n*error);
