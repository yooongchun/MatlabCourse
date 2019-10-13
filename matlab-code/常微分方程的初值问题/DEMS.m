function y = DEMS(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
for i=2:N+1
    fy = Funval(f,varvec,[x(i-1) y(i-1)]);
    z1 = y(i-1)+h*fy/3;
    fy1 = Funval(f,varvec,[x(i-1)+h/3 z1]);
    z2 = z1+h*(fy1-fy)/6;
    fy2 = Funval(f,varvec,[x(i-1)+h/3 z2]);
    z3 = z2+3*h*(fy2 - 4*fy1/9-fy/9)/8;
    fy3 = Funval(f,varvec ,[x(i-1)+h/2 z3]);
    z4 = z3+2*h*(fy3- 15*fy2/16 + 3*fy/16); 
    fy4 = Funval(f,varvec ,[x(i-1)+h z4]);
    y(i) = z4+h*(fy4 - 8*fy3 + 9*fy2 - 2*fy)/6;
end
format short;