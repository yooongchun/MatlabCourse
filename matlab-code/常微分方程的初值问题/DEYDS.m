function y = DEYDS(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0 + h*Funval(f,varvec, [x(1) y(1)]);
y(3) = y(2) + h*Funval(f,varvec, [x(2) y(2)]);
y(4) = y(3) + h*Funval(f,varvec, [x(3) y(3)]);
y(5) = y(4) + h*Funval(f,varvec, [x(4) y(4)]);
var = findsym(f);
for i=6:N+1
    y(i) = y(i-1)+h*(55*Funval(f,varvec,[x(i-1), y(i-1)])/24 -  ...
                        59*Funval(f,varvec,[x(i-2), y(i-2)])/24 + ...
                        37*Funval(f,varvec,[x(i-3), y(i-3)])/24 - ...
                        9*Funval(f,varvec,[x(i-4), y(i-4)])/24);
end
format short;