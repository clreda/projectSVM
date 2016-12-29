function C = choiceC(x, y)
% CHOICEC Chooses the best value for constant C using cross
% validation depending on samples.
% C = choiceC(x, y) Picks out the best value for C for
% samples (x, y) in range 1 to 10.
load crossvalidation.m;

% Bounds for c
c_max=5;
c_min=1;

C = c_min;
mini = crossvalidation(C, x, y);
for c_test=(c_min+1):c_max
    err = crossvalidation(c_test, x, y);
    if (mini > err)
        C = c_test;
        mini = err;
    end
end
