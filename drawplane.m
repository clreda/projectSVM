function drawplane(w,x,y)
% DRAWPLANE Draws a plane when d = 3
% drawplane(w,x,y)
% /!\ Only works if w(3) is non zero

% Plotting data points
class1 = (y' == 1);
class2 = (y' == -1);
xclass1 = x(:,class1);
xclass2 = x(:,class2);

plot3(xclass1(1,:),xclass1(2,:),xclass1(3,:),'+','Color','b','MarkerSize',6); hold on;
plot3(xclass2(1,:),xclass2(2,:),xclass2(3,:),'+','Color','r','MarkerSize',6); hold on;

grid on;
xlabel('x_1');
ylabel('x_2');
zlabel('x_3');
title('{\bf Classification frontier line (first three dimensions)}');

% Plotting hyperplane
xxmin = min(x(1,:));
xymin = min(x(2,:));

xxmax = max(x(1,:));
xymax = max(x(2,:));


%# create x,y
[xx,yy]=ndgrid(xxmin:xxmax,xymin:xymax);

%# calculate corresponding z
z = (-w(1)*xx - w(2)*yy - w(4))/w(3);

surf(xx,yy,z);

hold off
