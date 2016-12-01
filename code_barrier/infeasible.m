%% Infeasible start Newton method
%% Trouver un x qui satisfait Ax < b
%% Ou retourner une erreur

%% (w0, z0) est un point d'initialisation qui
%% appartient au domaine de f
function x = infeasible(C, x, y, w0, z0)
load gradient.m;
load hessian.m;
load f.m;
load backtracking.m;
load r.m;

% g est le gradient de la fonction objectif
g = gradient("f", {w0, z0, C, x, y})';
% h est la hessienne de la fonction objectif 
h = hessian("f", {w0, z0, C, x, y});

[s1 s2] = size(A);
% système KKT du problème infeasible
matrix1 = [h A'; A zeros(s2, s1)];
matrix2 = - [g + A'*nu; A*x - b];

% On initialise w, z et nu
z = z0;
w = w0;
nu = nu0;
tolerance = power([10], -16);
% Paramètres du backtracking
alpha = 0.01;
beta = 0.5;

% Calcul de la norme 2
n = norm2(matrix2(1, :), matrix(2, :));

while (~(A*x .< b) && n > tolerance)
    vector = matrix1\matrix2;
    p_step = vector(1, :);
    d_step = vector(2, :);
    % Backtracking
    t = backtracking(); (..........)
    t = 1;
    g = numgradient("f3", {c, x + t.*p_step});
    while (norm2(r(x + t.*p_step, nu + t.*d_step, A, b, g)) > (1 - alpha*t)*n)
        t = beta*t;
        g = numgradient("f3", {c, x + t.*p_step});
    end
    % Mise à jour
    x = x + t.*p_step;
    nu = nu + t.*d_step;
    g = numgradient("f3", {c, x});
    h = numberhessian("f3", {c, x});
    matrix1 = [h A'; A zeros(s2, s1)];
    matrix2 = - [g + A'*nu; A*x - b];
    n = norm2(matrix2(1, :), matrix2(2, :));
end

if ~(A*x .< b)
    "Point strictement faisable non trouvé."
end
