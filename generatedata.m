function [x y] = generatedata(number, dim, a1, a2, oneclass=ceil(number/2))
% number is the total number of samples
% dim is the dimension of the points
% oneclass is the number of elements in class 1
% a1, a2 are moments of gaussian functions
twoclass = number-oneclass;
% Generating 1st class elements
x1 = [];
for i=1:dim
	x1 = [x1 gaussian(oneclass, a1)];
        a1 += 1;
end
% Generating 2nd class elements 
x2 = [];
for i=1:dim
	x2 = [x2 gaussian(twoclass, a2)];
        a2 += 1;
end

% number x dim matrix 
x = [x1; x2];
% label of column i corresponds to label of point of
% row i in x 
y = [ones(oneclass, 1); (-ones(twoclass, 1))];
