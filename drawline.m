function _ = drawline(w, x, y)
% DRAWLINE Draws line when d = 2.

f = @(x) -(w(1)*x+w(3))/w(2);
f = @(x) -(w(1)*x+w(3)-1)/w(2);

x = x(1:2, :);
class1 = (y' == 1);
class2 = (y' == -1);
plot(x(1, class1), x(2, class1), 'bo');
hold on;
plot(x(1, class2), x(2, class2), 'ro');
hold on;
m = min(x(1, :));
M = max(x(1, :));
fm = f(m);
fM = f(M);
h = plot([m M], [fm fM]);
fm1 = 
set(h, 'Linewidth', 2);