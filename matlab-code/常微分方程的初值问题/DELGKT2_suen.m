function y = DELGKT2_suen(f, h,a,b,y0,varvec)
format long;
N = uint16((b-a)/h);
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
for i=2:N+1
    K1 = Funval(f,varvec,[x(i-1) y(i-1)]);
    K2 = Funval(f,varvec,[x(i-1)+2*h/3 y(i-1)+K1*2*h/3]);
    y(i) = y(i-1)+h*(K1+3*K2)/4;
end
format short;