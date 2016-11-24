%% f est la fonction barrière prenant en argument
%% A et b

%% x0 est un point d'initialisation appartenant
%% au domaine de f
function x=newton(A, b, x0)
pkg load optim;
load f.m;

% Initialiser le premier point
x = x0;
s = size(A)(1);

% Valeurs des paramètres différents de A et b
alpha = 0.01;
beta = 0.5;
% Valeur de tolérance pour la condition de sortie
% et pour le backtracking
tolerance = power([10], -10)(1);
% Vérifie lambda^2/2 > tolerance
lambda = power([10], -4)(1);

% Nombre d'itérations
k = 0; 
min = f(A, b, x);
maxiter = 1000;

cv = [];

while (power([lambda], 2)(1)/2 > tolerance && k < maxiter)
    k = k + 1;
    x1 = f(A, b, x);
    cv = [cv x1];
    if (x1 < min)
        min = x1;
    end
    % Calculer la hessienne et le gradient de f en x
    h = numhessian("f", {A, b, x});
    g = numgradient("f", {A, b, x})';
    % Calculer le pas de Newton
    step = -h\g;
    % Calculer l'inverse de la hessienne
    invH = h\eye(s);
    % Calculer le décrément de Newton
    lambda = power([g'*invH*g], 1/2);
    % Backtracking pour la longueur du pas
    t = 1;
    e1 = f(A, b, x + t*step);
    e2 = f(A, b, x) + (alpha*t).*g'*step;
    while (e1 - e2 >= tolerance)
        t = t*beta;
        e1 = f(A, b, x + t*step);
        e2 = f(A, b, x) + (alpha*t).*g'*step;
    end
    % Mise à jour de x
    x = x .- t*step;
end

if (k == maxiter)
    "La méthode de Newton n'a pas convergé."
end

k
x
f(A, b, x)
cv = cv .- min;
semilogy(1:k, cv);
