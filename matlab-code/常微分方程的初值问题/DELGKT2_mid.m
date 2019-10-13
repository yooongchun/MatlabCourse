function y = DELGKT2_mid(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
for i=2:N+1
    v1 = Funval(f,varvec,[x(i-1) y(i-1)]);
    t = y(i-1) + h*v1/2;
    v2 = Funval(f,varvec,[x(i)+h/2 t]);
    y(i) = y(i-1)+h*v2;
end
format short;