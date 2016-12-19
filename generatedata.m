function [x y] = generatedata(n, d, class1=ceil(n/2), m=0, sep=10, moment1=0.14, moment2=1)
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
end
if not(m)
    % Gaussian
    % Generating 1st class elements
    x1 = randn(d, class1) - sep;
    % Generating 2nd class elements 
    x2 = rand(d, class2) + sep;
end
if m==2
    x1 = [];
    x2 = [];
    for i=1:d
        g1 = gaussian(class1, moment1)';
        g2 = gaussian(class2, moment2)';
        % Dividing by std to improve plotting
        x1 = [x1; g1/std(g1)];
        moment1 += 0.01;
        x2 = [x2; g2/std(g2)];
        moment2 += 0.01;
    end
end

% (d+1) x n matrix 
x = [x1 x2; ones(1, n)];

% 1 x n matrix, y(i) corresponds to label of point x(i, :)
y = [ones(1, class1) (-ones(1, class2))];

