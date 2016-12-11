function confusion = testnewton(C, x, y, m1=0.5, m2=1)
% TESTNEWTON Generates data and trains/tests SVM
% confusion = testnewton(C, x, y) Returns confusion matrix
% for Gaussian moments 0.5 and 1.
% confusion = testnewton(C, x, y, m1) Returns confusion matrix
% for Gaussian moments m1 and 1.
% confusion = testnewton(C, x, y, m1, m2) Returns confusion matrix
% for Gaussian moments m1 and m2.

load generatedata.m;
load barrier.m;

"X and Y vectors for this test:"
x'
y'

[n, d] = size(x);

"Initialization of Lagrange multiplier a = ainit"
ainit = C/2*ones(1, n)
"satisfies 0 < a < C"
"Dual solution:"
a = barrier(x, y, C, ainit)
"Primal solution:"
w = sum((a .* y)'*x)

% Testing
[x1, y1] = generatedata(300, d, m1, m2)
"Computing out-of-sample performance"
confusion = zeros(2, 2);
onfrontier = 0;
for i=1:number
    l = (w*x1(i, :))(1, 1);
    if (l >= 1)
        if (y1(i) == 1)
            confusion(1, 1) += 1;
        else
            confusion(2, 1) += 1;
        end
    end
    if (l <= -1)
        if (y1(i) == -1)
            confusion(2, 2) += 1;
        else
            confusion(1, 2) += 1;
        end
    else
        "This point is on the frontier"
        onfrontier += 1;
        x1(i, :)
    end
end

"Out-of-sample performance"
confusion
(confusion(1, 2) + confusion(2, 1) + onfrontier)/n
    
           
