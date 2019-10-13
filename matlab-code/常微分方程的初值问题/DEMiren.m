function y = DEMiren(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0 + h*Funval(f,varvec, [x(1) y(1)]);
y(3) = y(2) + h*Funval(f,varvec, [x(2) y(2)]);
y(4) = y(3) + h*Funval(f,varvec, [x(3) y(3)]);
var = findsym(f);
for i=5:N+1
    y(i) = y(i-4)+4*h*(2*Funval(f,varvec,[x(i-1), y(i-1)]) - ...
                        Funval(f,varvec,[x(i-2), y(i-2)]) + ...
                        2*Funval(f,varvec,[x(i-3), y(i-3)]))/3;
end
format short;