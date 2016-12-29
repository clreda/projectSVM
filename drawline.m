function drawline(w, x, y)
% DRAWLINE Draws classification frontier line when d = 2.
% drawline(w, x, y)

f = @(x) -(w(1)*x+w(3))/w(2);
f1 = @(x) 1-(w(1)*x+w(3))/w(2);
f2 = @(x) -1-(w(1)*x+w(3))/w(2);

x = x(1:2, :);
class1 = (y' == 1);
class2 = (y' == -1);
plot(x(1, class1), x(2, class1), 'bo');
hold on;
plot(x(1, class2), x(2, class2), 'ro');
hold on;
minx = min(x(1, :));
maxx = max(x(1, :));
h = fplot(f, [minx maxx], 'g');
h1 = fplot(f1, [minx maxx], 'b--');
h2 = fplot(f2, [minx maxx], 'r--');