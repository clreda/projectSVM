function a = test_newton(C, number, dim, oneclass=ceil(number/2))

[x, y] = generatedata(number, dim, oneclass);
"X and Y vectors for this test:"
x
y

"Initialization of Lagrange multiplier a = ainit"
ainit = zeros(1, number)
"Dual solution:"
a = barrier(x, y, C, ainit)
"Primal solution:"
v = sum(a .* y);
w = v'*x

"Computing out-of-sample performance"
confusion = zeros(2, 2);
onfrontier = 0;
for i=1:n
    if (w'*x(i, :) >= 1)
        if (y(i) == 1)
            confusion(1, 1) = confusion(1, 1) + 1;
        else
            confusion(2, 1) = confusion(2, 1) + 1;
        end
    end
    if (w'*x(i, :) <= -1)
        if (y(i) == -1)
            confusion(2, 2) = confusion(2, 2) + 1;
        else
            confusion(1, 2) = confusion(1, 2) + 1;
        end
    else
        "This point is on the frontier"
        onfrontier = 1 + onfrontier;
        x(i, :)
    end
end

"Out-of-sample performance"
(confusion(1, 2) + confusion(2, 1) + onfrontier)/(number)
    
           