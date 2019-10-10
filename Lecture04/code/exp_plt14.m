x=-2:0.1:2;
y=-2:0.1:2;
[X,Y]=meshgrid(x,y);
Z=X.^2+Y.^2-0.5*(x.^2).*(Y.^2);
figure,surf(X,Y,Z);
figure,mesh(X,Y,Z);

x=-3:0.25:3;
y=-3:0.25:3;
[X,Y] = meshgrid(x,y);
Z=1.8.^(-1.5*sqrt(X.^2+Y.^2)).*cos(0.5*Y).*sin(X);
figure,mesh(X,Y,Z);xlabel('x');ylabel('y');zlabel('z');
figure,meshc(X,Y,Z);xlabel('x');ylabel('y');zlabel('z');
figure,surf(X,Y,Z);xlabel('x');ylabel('y');zlabel('z');
figure,surfc(X,Y,Z);xlabel('x');ylabel('y');zlabel('z');