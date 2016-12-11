function C = choiceC(x, y, c_max=10)
% CHOICEC Chooses the best value for constant C using cross
% validation depending on samples.
% C = choiceC(x, y) Picks out the best value for C for
% samples (x, y) in range 1 to 10.
% C = choiceC(x, y, c_max) in range 1 to c_max.

load crossvalidation.m;

C = 1;
mini = crossvalidation(1, x, y);
for c_test=2:c_max
    error = crossvalidation(c_test, x, y);
    if (mini > error)
        C = c_test;
    end
end