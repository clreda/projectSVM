function confusion = test_newton(C, x, y, a1=0.5, a2=1)
load generatedata.m
load barrier.m

"X and Y vectors for this test:"
x'
y'

number = size(x)(1);

"Initialization of Lagrange multiplier a = ainit"
ainit = zeros(1, number)
"Dual solution:"
a = barrier(x, y, C, ainit)
"Primal solution:"
w = sum(a .* y .* x)

[x1, y1] = generatedata(300, size(x)(2), a1, a2)
"Computing out-of-sample performance"
confusion = zeros(2, 2);
onfrontier = 0;
for i=1:number
    if (w*x1(i, :) >= 1)
        if (y1(i) == 1)
            confusion(1, 1) += 1;
        else
            confusion(2, 1) += 1;
        end
    end
    if (w*x1(i, :) <= -1)
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
(confusion(1, 2) + confusion(2, 1) + onfrontier)/(number)
    
           
