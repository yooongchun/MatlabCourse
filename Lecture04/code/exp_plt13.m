t=0:0.05:15;
x=exp(-0.05*t).*cos(2*t);
y=exp(-0.05*t).*sin(2*t);
z=t;
figure
plot3(x,y,z,'.');
xlabel('x(meters)');
ylabel('y(meters)');
zlabel('z(meters)');
title('3D line plot');

