% g est le gradient de f en x
function a = r(x, nu, A, b, g)
a = [g + A'*nu; A*x - b]