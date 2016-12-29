function err = crossvalidation(C, x, y)
% CROSSVALIDATION Computes mean-square prediction error for samples x and
% constant C with "leave-one-out" technique, using log-barrier function method.
% error = crossvalidation(C, x, y) for samples x associated with labels y.
load barrier.m;

err = [];
[d, n] = size(x);
for j=1:n
    % Training set
    inval = setxor(1:n, j);
    train = x(:, inval);
    trainl = y(:, inval);
    test = x(:, j);
    testl = y(:, j);

    % Training : ai = C/2 satisfies the condition 0 <= a <= C
    [al, wl] = barrier(train, trainl, C, C/2*ones(n-1, 1));
    % Dual solution
    a = al(:, end);
    % Primal solution
    w = wl(:, end);
    % Confusion matrix
    if (or(and(w*test > 0, testl == 1), 
         and(w*test <= 0, testl == -1)))
        err = [err; 0];
    else
        err = [err; 1];
    end
    
end
err = sum(err);
