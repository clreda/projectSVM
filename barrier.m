%% Log barrier function
function a = barrier(x, y, C, ainit)

% Initializing 
a = ainit;
m = size(a,1);
K = x*x';

% Parameters
tolerance = 1e-10;
mu = 10;
t = 1;

while (m/t > tolerance)
    % Update a and t
    a = newton(K, y, C, ainit, t);
    t = mu*t;
end
