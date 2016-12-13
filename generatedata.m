function [x y] = generatedata(n, d, class1=ceil(n/2))
% GENERATEDATA Generates two classes of samples and labels in
% number n and of dimension d with two Gaussian functions of
% different moments.
% x of dimension d x n and y of dimension 1 x n
% [x, y] = generatedata(n, d) Generates two classes (first class
% having ceil(n/2) elements)
% [x, y] = generatedata(n, d, class1) Generates two classes (first class
% having class1 elements) 

class2 = n-class1;
% Generating 1st class elements
x1 = 100*rand(d, class1);
% Generating 2nd class elements 
x2 = -100*rand(d, class2);

% d x n matrix 
x = [x1; x2]';

% 1 x d matrix, y(i) corresponds to label of point x(i, :)
y = [ones(1, class1) (-ones(1, class2))];

