x=0:0.02:5;
y=0:0.02:5;
[X,Y]=meshgrid(x,y);
Z=X+Y;
Z(X+2*Y==3)=nan;
mesh(X,Y,Z);