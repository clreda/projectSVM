%% (w0, z0) est un point d'initialisation strictement faisable
function x = barrier(C, x, y, w0, z0)
% Initialiser le premier point
w = w0;
z = z0;
s = size(A)(1);

tolerance = power([10], -10);
mu = 10;
t = 1;
% b est un vecteur colonne
m = size(b)(1);

while (m/t > tolerance)
    x = newton(C, x, y, w, z, t);
    t = mu*t;
end
