function [x y] = generatedata(n, d, class1=ceil(n/2), m=0)
% GENERATEDATA Generates two classes of samples and labels in
% number n and of dimension d with two Gaussian functions of
% different moments.
% x of dimension (d+1) x n and y of dimension 1 x n
% [x, y] = generatedata(n, d) Generates two classes (first class
% having ceil(n/2) elements)
% [x, y] = generatedata(n, d, class1) Generates two classes (first class
% having class1 elements) 

class2 = n-class1;
if m
    % Uniform in (0, 1)
    % Generating 1st class elements
    x1 = 100*rand(d, class1);
    % Generating 2nd class elements 
    x2 = -100*rand(d, class2);
else
    % Gaussian
    % Generating 1st class elements
    x1 = randn(d, class1) - 10;
    % Generating 2nd class elements 
    x2 = rand(d, class2) + 10;
end

% (d+1) x n matrix 
x = [x1 x2; ones(1, n)];

% 1 x n matrix, y(i) corresponds to label of point x(i, :)
y = [ones(1, class1) (-ones(1, class2))];

