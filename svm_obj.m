% the objective function is t*a'(K .* yy')a/2 - 1^Ta - log(a(C-a))
%                           (subject to 0 < a < C) 

function [f, gradf, hessf] = svm_obj(a,K,y,C,t)

% K = [nxn] Kernel matrix
% y = [nx1] output
% a = [n*1]
% C = [1x1] classification error

G = K.*(y*y'); % nxn
n = size(a);
d = a.*(C*ones(n,1) - a);
D = diag(1./d);
vec = ones(1,n);
Cvec = C*ones(n,1);

f = t*(a'*G*a/2 - vec*a) - log(d')*ones(n,1);
gradf = t*((G'+G)*a/2-vec') - D*(Cvec-2*a); % derivative -log(a(C-a)) = (C-2a)/(a(C-a))
hessf = t*((G'+G)/2)+ diag(D^2*(Cvec + 2*(a.*Cvec)+2*(a.*a)));
