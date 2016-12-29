function [a, w, alist, wlist] = main(C, x, y)
% MAIN Trains/tests SVM on data
% [a, w, alist, wlist] = main(C, x, y) Returns dual and primal solutions
% for data x, y
load barrier.m;

n = size(x, 2);

% Training 2/3 of the whole data
sizet = ceil(2/3*size(x, 2));
t = randperm(n, sizet);
train = x(:, t);
trainl = y(:, t);
% Testing 1/3 of the whole data
test = x(:, setxor(1:n, t));
testl = y(:, setxor(1:n, t));

% Training on training set
% a = [C/2; C/2; C/2; ...; C/2] strictly satisfies
% condition 0 < a < C
ainit = C/2*ones(sizet, 1);
"Dual solution"
tic
% a is of size size(t, 2) x 1
[alist, wlist] = barrier(train, trainl, C, ainit);
toc
a = alist(:, end);
"Primal solution"
% w of size 1 x (d+1)
w = wlist(:, end);

% Testing on testing set
"Computing out-of-sample performance"
confusion = zeros(2, 2);
%onfrontier = 0;
ll = (w'*test);
% Class 1 is y = 1 (ll > 0), class2 is y = -1 (ll < 0)
ptsin1 = testl(ll > 0)';
ptsin2 = testl(ll < 0)';
frontier = abs(testl(ll == 0))';
confusion(1, 1) = sum(ptsin1(ptsin1 > 0));
confusion(2, 2) = abs(sum(ptsin2(ptsin2 < 0)));
confusion(1, 2) = abs(sum(ptsin1(ptsin1 < 0)));
confusion(2, 1) = sum(ptsin2(ptsin2 > 0));
onfrontier = sum(frontier);

confusion
onfrontier
outofsampleperf = (confusion(1, 1) + confusion(2, 2))/(n - sizet)
% Draws frontier for the first two dimensions
drawline(w, x, y);
           
