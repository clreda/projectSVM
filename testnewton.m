function confusion = testnewton(C, x, y, sizetest=300, m1=0.5, m2=1)
% TESTNEWTON Generates data and trains/tests SVM
% confusion = testnewton(C, x, y) Returns confusion matrix
% for Gaussian moments 0.5 and 1, tested on sample of size 300.
% confusion = testnewton(C, x, y, sizetest) Returns confusion matrix
% for Gaussian moments 0.5 and 1, tested on sample of size sizetest.
% confusion = testnewton(C, x, y, sizetest, m1, m2) Returns confusion matrix
% for Gaussian moments m1 and m2, tested on sample of size sizetest.

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
a = barrier(x, y, C, ainit)
toc
"Primal solution:"
% w of size 1 x (d+1)
w = (a .* y')' * x'

% Testing (x1 of size (d+1) x n, y1 of size 1 x n)
[x1, y1] = generatedata(sizetest, d);
"Computing out-of-sample performance"
confusion = zeros(2, 2);
%onfrontier = 0;
ll = (w*x1);
% Class 1 is y = 1, class2 is y = -1
y1(y1 == -1) = 0;
ptsin1 = y1(ll >= 1)';
y1(y1 == 0) = -1;
y1(y1 == 1) = 0;
ptsin2 = -y1(ll <= -1)';
frontier = y1(and(ll > -1, ll < 1))';
confusion(1, 1) = sum(ptsin1);
confusion(2, 2) = sum(ptsin2);
confusion(1, 2) = length(ptsin1) - confusion(1, 1);
confusion(2, 1) = length(ptsin2) - confusion(2, 2);
onfrontier = length(frontier);
%for i=1:sizetest
%    l = w*x1(:, i)
%    y1(1, i)
%    if (l >= 1)
%        if (y1(1, i) == 1)
%            confusion(1, 1) += 1;
%        else
%            confusion(2, 1) += 1;
%        end
%    end
%    if (l <= -1)
%        if (y1(1, i) == -1)
%            confusion(2, 2) += 1;
%        else
%            confusion(1, 2) += 1;
%        end
%    end
%    if (l > -1 && l < 1)
%        "This point is on the frontier"
%        onfrontier += 1;
%        x1(:, i)
%    end
%end

confusion
onfrontier
outofsampleperf = (confusion(1, 1) + confusion(2, 2))/sizetest
           
