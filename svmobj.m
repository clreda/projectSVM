function [f, gradf, hessf] = svmobj(a, K, y, C, t)
% SVMOBJ Returns value, gradient and hessian for objective function 
% t/2*a'diag(y)*K*diag(y)*a - 1^Ta - log(1./(a.*(C.-a)))
% [f, gradf, hessf] = svmobj(a, K, y, C, t) for labels y : n x 1, kernel
% matrix K : n x n, Lagrange multiplier a : n x 1, constant
% for classification error C : 1 x 1.

% n x n matrix
G = diag(y)*K*diag(y);
n = size(a);
vec = ones(1, n);
Cvec = C*vec';
d = a .* (Cvec .- a);
%% Ce ne serait pas plutôt D = diag(d) ?
D = diag(1 ./ d);

f = t*a*G*(a'./2) - vec*a' - log(d')*vec';
%% L'ancienne ligne était : (t*(a*(G*a'./2) - vec*a))' .- log(d')*vec';

fprintf("lalalalolo\n")

%size(t)
%size((G' .+ G)*a'./2)
%size(vec')
%size(D)
%size(Cvec-2*a)
%size(D*(Cvec - 2*a)')

gradf = t*((G' + G)*a'./2 .- vec') - D*(Cvec - 2*a)'; 
% derivative -log(a(C-a)) = (C-2a)/(a(C-a))

%size(D^2)
%size(Cvec + 2*(a .* Cvec))

hessf = (t/2)*(G' + G + power(D, 2)*(Cvec + 2*(a * Cvec)' + 2*(a .* a)));
% Au niveau du calcul de la hessienne, il y a cette erreur :
%warning: matrix singular to machine precision, rcond = nan
%*** Error in `/usr/bin/octave-cli': double free or corruption (!prev): 0x0000000002756680 ***
%panic: Aborted -- stopping myself...
