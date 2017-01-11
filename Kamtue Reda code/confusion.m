function [conf fail] = confusion(w, x, y)
n = size(x, 2);

% Testing on testing set
conf = zeros(2, 2);
ll = (w'*x);
% Class 1 is y = 1 (ll > 0), class2 is y = -1 (ll < 0)
ptsin1 = y(ll > 0)';
ptsin2 = y(ll < 0)';
frontier = abs(y(ll == 0))';
conf(1, 1) = sum(ptsin1(ptsin1 > 0));
conf(2, 2) = abs(sum(ptsin2(ptsin2 < 0)));
conf(1, 2) = abs(sum(ptsin1(ptsin1 < 0)));
conf(2, 1) = sum(ptsin2(ptsin2 > 0));
onfrontier = sum(frontier);

fail = (conf(1, 2) + conf(2, 1))/n;