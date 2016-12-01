%% f est la fonction barrière prenant en argument
%% A et b

%% x0 est un point d'initialisation appartenant
%% au domaine de f
function x=newton(A, b, x0)
pkg load optim;
load f.m;
load backtracking.m;

% Initialiser le premier point
x = x0;
s = size(A)(1);

% Valeur de tolérance pour la condition de sortie
tolerance = power([10], -16)(1);
% Vérifie lambda^2/2 > tolerance
lambda = power([10], -4)(1);

% Nombre d'itérations
k = 0; 
min = f(A, b, x);
maxiter = 1000;

cv = f(A, b, x);

while (and(f(A, b, x) < cv(1, end), and(power([lambda], 2)(1)/2 > tolerance, k < maxiter)))
    (f(A, b, x) < cv(1, end))
    k = k + 1
    f(A, b, x)
    cv(1, end)
    cv = [cv f(A, b, x)];
    if (cv(1, end) < min)
        min = cv(1, end);
    end
    % Calculer la hessienne et le gradient de f en x
    h = numhessian("f", {A, b, x});
    g = numgradient("f", {A, b, x})';
    % Calculer le pas de Newton
    step = -h\g;
    % Calculer l'inverse de la hessienne
    invH = cholinv(H);
    % Calculer le décrément de Newton
    lambda = power([g'*invH*g], 1/2);
    % Backtracking pour la longueur du pas
    t = backtracking(A, b, x, step, g);
    % Mise à jour de x
    x = x .- t*step;
end

if (k == maxiter)
    "La méthode de Newton n'a pas convergé."
end

k
x
f(A, b, x)
cv = cv .- min
plot(1:k, cv);
