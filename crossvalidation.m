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

    % Training : ai = C/2 always satisfies the condition 0 <= a <= C
    [_, wl] = barrier(train, trainl, C, C/2*ones(n-1, 1));
    % Primal solution
    w = wl(:, end);
    
    % Error computation
    isinclass1 = (w'*test > 0)
    isinrightclass1 = isinclass1*testl == 1
    isinrightclass2 = (isinclass1 + 1)*testl == -1
    if or(isinrightclass1, isinrightclass2)
        err = [err; 0];
    else
        err = [err; 1];
    end
end
err = 1/n*sqrt(sum(err));
