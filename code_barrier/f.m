function a = f(w, z, C, x, y)
% z est un vecteur colonne
n = size(z)(1);
a = 1/2*w'*w + C*ones(1, n)*z;