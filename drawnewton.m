function drawnewton(nbiter, cv)
% DRAWNEWTON Draws Newton's method convergence
% in semi-log scale.
% drawnewton(nbiter, cv)

semilogy(1:nbiter, cv);
hold on;
ylabel('|f(w^n) - f_{min}|');
xlabel('Number of iterations n');
title('{\bf Newton s method convergence}');
hold off
