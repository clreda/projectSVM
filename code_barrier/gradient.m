function g = gradient(w, z, C)
% w et z sont des vecteurs colonne
g = [sum(w); C*size(z)(1)];