% Compute prediction error
function error = crossvalidation(C, x, y)
load barrier.m

% Leave-one-out method
error = [];

% x is a number x dim matrix
n = size(x)(1);
for j=1:n
    training = x([1:(j-1) (j+1):n], :);
    trainingl = y([1:(j-1) (j+1):n], :);
    testing = x(j, :);
    testingl = y(j, :);

    % training
    ainit = zeros(1, number);
    a = barrier(training, trainingl, C, ainit);
    w = sum(a' .* trainingl' .* training');
    % Confusion matrix
    if (w*testing != testingl)
        error = [error 1];
    else
        error = [error 0];
    end
end
error = sqrt(1/n*error);
