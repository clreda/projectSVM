function t = backtracking(A, b, x, step, g)
load f.m;

% Valeur de tolérance pour le backtracking
tolerance = power([10], -16)(1);
% Valeurs des paramètres différents de A et b
alpha = 0.01;
beta = 0.5;

t = 1;
e1 = f(A, b, x + t*step);
e2 = f(A, b, x) + (alpha*t).*g'*step;
while (e1 - e2 >= tolerance)
    t = t*beta;
    e1 = f(A, b, x + t*step);
    e2 = f(A, b, x) + (alpha*t).*g'*step;
end