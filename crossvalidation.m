% Compute prediction error
function error = crossvalidation(C, x, y)
load barrier.m

% Leave-one-out method
error = 0;

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
    w = sum(a .* trainingl .* training);
    confusion = zeros(2, 2);
    onfrontier = 0;
    for i=1:number
        if (w*testing(i, :) >= 1)
            if (testingl(i) == 1)
                confusion(1, 1) += 1;
            else
                confusion(2, 1) += 1;
            end
        end
        if (w*testing(i, :) <= -1)
            if (testingl(i) == -1)
                confusion(2, 2) += 1;
            else
                confusion(1, 2) += 1;
            end
        else
            "This point is on the frontier"
            onfrontier += 1;
            x1(i, :)
        end
    end
    error += confusion(1, 2) + confusion(2, 2);
end
error = sqrt(1/n*(error'*error));
