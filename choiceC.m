% Choosing the best value for C using crossvalidation
% Depending on the type of samples
function C = choiceC(x, y, c_max)
load crossvalidation.m;

C = 1;
mini = crossvalidation(1, x, y);
for c=2:c_max
    error = crossvalidation(c, x, y);
    if (mini > error)
        C = c;
    end
end