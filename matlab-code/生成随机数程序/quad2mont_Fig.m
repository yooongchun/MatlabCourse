% 求体积的蒙特卡洛模拟值时的示意图
t = linspace(0,pi,100);
x = cos(t)+1;
y = sin(t);
z = zeros(size(x));
zz = sqrt(4-x.^2-y.^2);
plot3(x,y,z,'k');
hold on
fill3([x x(1)],[y y(1)],[z z(1)],[0.7,0.7,0.7]);
plot3(x,y,zz,'k');
text(0,-0.2,0,'O')
text(1,0.5,0,'D')
line([x;x],[y;y],[z;zz],'LineStyle',':','color',[0.5 0.5 0.5])
t = linspace(0,pi/2,100);
x = 2*cos(t);
y = 2*sin(t);
z = zeros(size(x));
plot3(x,y,z,'k');

y = 2*cos(t);
z = 2*sin(t);
x = zeros(size(y));
plot3(x,y,z,'k');

x = 2*cos(t);
z = 2*sin(t);
y = zeros(size(x));
plot3(x,y,z,'k');

quiver3(0,0,0,1,0,0,2.2,'k','filled','LineWidth',2);
quiver3(0,0,0,0,1,0,2.2,'k','filled','LineWidth',2);
quiver3(0,0,0,0,0,1,2.2,'k','filled','LineWidth',2);
text(0,0.15,2.16,'Z')
text(0,2.2,0.2,'Y')
text(2.45,0,0.25,'X')

axis equal
axis([0 2.2 0 2.2 0 2.2])
axis off
view(116,20);