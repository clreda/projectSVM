%% Log barrier
function a = barrier(x,y,C,ainit)

% Initializing 
a = ainit;
m = size(a,1);
K = x*x';

% parameters
tolerance = 1e-10;
mu = 10;
t = 1;

while (m/t > tolerance)
    % update a and t
    a = newton(K,y,C,ainit,t);
    t = mu*t;
end