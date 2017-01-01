function C = choiceC(x, y, c_max=10, c_min=1)
% CHOICEC Chooses the best value for constant C using cross
% validation depending on samples.
% C = choiceC(x, y) Picks out the best value for C for
% samples (x, y) in range 1 to 10.
% C = choiceC(x, y, c_max, c_min) in range c_min to c_max.

load crossvalidation.m;

mini = crossvalidation(c_min, x, y);
for c_test=(c_min+1):c_max
    err = crossvalidation(c_test, x, y);
    if (mini > err)
        C = c_test;
        mini = err;
    end
end
