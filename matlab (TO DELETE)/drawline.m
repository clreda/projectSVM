function _ = drawline(w, x, y)
% DRAWLINE Draws line when d = 2.
% _ = drawline(w, x, y)

f = @(x) -(w(1)*x+w(3))/w(2);
f1 = @(x) -(w(1)*x+w(3)-1)/w(2);
f2 = @(x) -(w(1)*x+w(3)+1)/w(2);

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
set(h, 'Linewidth', 2);
%fm1 = f1(m);
%fM1 = f1(M);
%h1 = plot([m M], [fm1 fM1]);
%set(h1, 'Linewidth', 1);
%fm2 = f2(m);
%fM2 = f2(M);
%h2 = plot([m M], [fm2 fM2]);
%set(h2, 'Linewidth', 1);
