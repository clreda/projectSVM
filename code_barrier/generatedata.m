function [C x y] = generatedata(n, dim, C)
a1 = 0.5;
x = [];
for i=1:dim
	x = [x gaussian(ceil(n/2), a1)];
	a1 += 1;
end
a2 = dim + 14;
x1 = [];
for i=1:dim
	x1 = [x1 gaussian(ceil(n/2), a2)];
        a2 += 1;
end

% dim x n matrix 
x = [x; x1];
% label of column i corresponds to label of point of
% row i in x 
y = [ones(floor(n/2), 1); (-ones(ceil(n/2), 1))];
