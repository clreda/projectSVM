function [x y x1 y1] = convertdata(train, test, s)

x = [train(:, 1:2) ones(size(train, 1), 1)];
x = [x; test(:, 1:2) ones(size(test, 1), 1)];
x = x';

y = train(:, 3);
y = [y; test(:, 3)];
y(y == 0) = -1;
y = y';

t = randperm(size(x, 2), s);
x1 = x(:, t);
y1 = y(:, t);

