function [a, w, alist, wlist] = main(C, x, y, sizetest=300, m=0, sep=10, class1test=ceil(sizetest/2))
% MAIN Generates data and trains/tests SVM
% confusion = testnewton(C, x, y) Returns confusion matrix
% tested on sample of size 300.
% confusion = testnewton(C, x, y, sizetest) Returns confusion matrix
% tested on sample of size sizetest.
load generatedata.m;
load barrier.m;

n = size(x, 2);
d = size(x, 1)-1;

% a = [C/2; C/2; C/2; ...; C/2] strictly satisfies
% condition 0 < a < C
ainit = C/2*ones(n, 1);
"Dual solution:"
tic
% a is of size n x 1
[alist, wlist] = barrier(x, y, C, ainit);
toc
wlist = reshape(wlist, 3, size(wlist, 2)*size(wlist, 1)/3);
a = alist(:, end);
"Primal solution:"
% w of size 1 x (d+1)
w = wlist(:, end);

% Testing (x1 of size (d+1) x n, y1 of size 1 x n)
[x1, y1] = generatedata(sizetest, d, class1test, m, sep);
"Computing out-of-sample performance"
confusion = zeros(2, 2);
%onfrontier = 0;
ll = (w'*x1);
% Class 1 is y = 1 (ll > 0), class2 is y = -1 (ll < 0)
ptsin1 = y1(ll > 0)';
ptsin2 = y1(ll < 0)';
frontier = abs(y1(ll == 0))';
confusion(1, 1) = sum(ptsin1(ptsin1 > 0));
confusion(2, 2) = abs(sum(ptsin2(ptsin2 < 0)));
confusion(1, 2) = abs(sum(ptsin1(ptsin1 < 0)));
confusion(2, 1) = sum(ptsin2(ptsin2 > 0));
onfrontier = sum(frontier);

confusion
onfrontier
outofsampleperf = (confusion(1, 1) + confusion(2, 2))/sizetest
drawline(w, [x x1], [y y1])
           
