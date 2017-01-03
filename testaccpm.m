%% test accpm
function testaccpm()

%% Initilisation
[x,y] = generatedata(8,2);

[ndim,nsample] = size(x);

A = diag(y)*x';

A = [A -eye(nsample)];
b= -ones(nsample,1);

vecinit = [ones(ndim,1);500*ones(nsample,1)];
factor = -max(A*vecinit);
vecinit = vecinit / (factor/2);

%% Find w et z using ACCPM

% C = 4
vec = accpm(4, A, b, vecinit); 

w = vec(1:ndim);
%% Visualize data

%drawplane(w,x,y);
drawline(w,x,y);
