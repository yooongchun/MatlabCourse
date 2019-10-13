function y = DELGKT4_jer(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
C2 = sqrt(2);
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
for i=2:N+1
    K1 = Funval(f,varvec,[x(i-1) y(i-1)]);
    K2 = Funval(f,varvec,[x(i-1)+h/2 y(i-1)+K1*h/2]);
    K3 = Funval(f,varvec,[x(i-1)+h/2 y(i-1)+K1*h*(C2-1)/2+K2*h*(2-C2)/2]);
    K4 = Funval(f,varvec,[x(i-1)+h y(i-1)-K2*h*C2/2+K3*h*(2+C2)/2]);
    y(i) = y(i-1)+h*(K1+(2-C2)*K2+(2+C2)*K3+K4)/6;
end
format short;