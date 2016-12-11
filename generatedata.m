function [x y] = generatedata(n, d, m1=0.5, m2=1, class1=ceil(n/2))
% GENERATEDATA Generates two classes of samples and labels in
% number n and of dimension d with two Gaussian functions of
% different moments.
% x of dimension d x n and y of dimension 1 x n
% [x, y] = generatedata(n, d) Generates two classes (first class
% having ceil(n/2) elements) with moments 0.5 and 1
% [x, y] = generatedata(n, d, m1) Generates two classes (first class
% having ceil(n/2) elements) with moments m1 and 1
% [x, y] = generatedata(n, d, m1, m2) Generates two classes (first class
% having ceil(n/2) elements) with moments m1 and m2
% [x, y] = generatedata(n, d, m1, m2, class1) Generates two classes (first class
% having class1 elements) with moments m1 and m2

class2 = n-class1;
% Generating 1st class elements
x1 = [];
for i=1:d
	x1 = [x1 gaussian(class1, m1)];
        m1 += 1;
end
% Generating 2nd class elements 
x2 = [];
for i=1:d
	x2 = [x2 gaussian(class2, m2)];
        m2 += 1;
end

% d x n matrix 
x = [x1; x2]';

% 1 x d matrix, y(i) corresponds to label of point x(i, :)
y = [ones(1, class1) (-ones(1, class2))];

