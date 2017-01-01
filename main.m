function [a, w, alist, wlist, confusion, failurerate] = main(C, x, y, algo)
% MAIN Trains/tests SVM on data
% [a, w, alist, wlist, confusion, failurerate] = main(C, x, y,
% algo) Returns dual and primal solutions for data x, y.
% algo = 0 : uses Newton's method
% algo = 1 : uses Coordinate Descent
% algo = 2 : uses ACCPM
load barrier.m;
load coorddescent.m;
load accpm.m;
load drawnewton.m;

[d, n] = size(x);

% Training 2/3 of the whole data
sizet = ceil(2/3*size(x, 2));
t = randperm(n, sizet);
train = x(:, t);
trainl = y(:, t);
% Testing 1/3 of the whole data
test = x(:, setxor(1:n, t));
testl = y(:, setxor(1:n, t));

% Training on training set
if (algo < 2)
       % a = [C/2; C/2; C/2; ...; C/2] strictly satisfies
       % condition 0 < a < C
       ainit = C/2*ones(sizet, 1);
       if (algo == 0)
          tic
          [alist, wlist, cv] = barrier(train, trainl, C, ainit, 0);
          toc
          % Plots Newton's method convergence
          drawnewton(size(cv, 2), cv);
       else 
          tic
          % a is of size size(t, 2) x 1
          [alist, wlist] = coorddescent(C, train, trainl, ainit);
          toc
       end
       % a is of size size(t, 2) x 1
       a = alist(:, end);
       % w of size 1 x (d+1)
       w = wlist(:, end);
else
       % Minimize 1/2||w||^2 + C 1^Tz
       % s.t. z >= 0
       % forall i, y_i(w^Tx_i) >= 1 -  z_i
       % <=> [-y_i*x_i^T -1]*[w z_i]^T <= -1
       % <=> A*x <= b
       A = [];
       for i=1:n
           A = [A; -y(1, i).*x(1:(end-1), i)' -1];
       end
       A = A';
       b = -ones(d, 1);
       % xinit belongs to the initial polygon
       xinit = A\b;
       xans = accpm(C, A, b, xinit);
       w = xans(1:(end-1), :);
       z = xans(end, :);
       % Null vectors
       a = [];
       alist = [];
       wlist = [];
end
% Testing on testing set
"Computing out-of-sample performance";
confusion = zeros(2, 2);
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

failurerate = (confusion(1, 2) + confusion(2, 1))/(n - sizet);
           
