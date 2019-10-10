t=0:0.2:10;
x=t;
y=sin(t);
z=t.^1.5;
stem3(x,y,z,'fill')
grid on
xlabel('x');
ylabel('y');
zlabel('z');