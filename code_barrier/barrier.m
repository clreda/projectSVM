%% x0 est un point d'initialisation strictement faisable
function x=barrier(A, b, c, x0)
% Initialiser le premier point
x = x0;
s = size(A)(1);

tolerance = power([10], -10);
mu = 10;
t = 1;
% b est un vecteur colonne
m = size(b)(1);

while (m/t > tolerance)
    x = newton2(A, b, c, t, x);
    t = mu*t;
end