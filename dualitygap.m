function dualitygap(listw, lista)
% DUALITYGAP Plots duality gap w^n-a^n as a function 
% of the number n of Newton iterations
% dualitygap(listw, lista)

n = size(lista, 2);

l1 = [];
l2 = [];
for i=1:n
     l1 = [l1 norm(listw(:, i))];
     l2 = [l2 norm(lista(:, i))];
end

plot(1:n, abs(l1 - l2), 'b--');
hold on;
xlabel('|w^n - a^n|');
ylabel('Number of Newton iterations');
title('{\bf Duality gap}');
hold off
