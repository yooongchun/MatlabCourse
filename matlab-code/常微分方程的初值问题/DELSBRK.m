function y = DELSBRK(f, h,a,b,y0,varvec)
format long;
a1 = 1.40824829;
a2 = 0.59175171;
c1 = 0.17378667;
c2 = c1;
w1 = -0.41315432;
w2 = 1.41315432;
N = (b-a)/h;
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
dy = diff(f, varvec(2));
for i=2:N+1
    f1 = Funval(f,varvec,[x(i-1) y(i-1)]);
    dy1 = Funval(dy,varvec,[x(i-1) y(i-1)]);
    k1 = h*f1/(1-h*a1*dy1); 
    dy2 = Funval(dy,varvec,[x(i-1)+c1*h y(i-1)+c2*k1]);   
    f2 = Funval(f,varvec,[x(i-1)+c1*h y(i-1)+c2*k1]);
    k2 = h*f2/(1-h*a2*dy2);
    y(i) = y(i-1)+w1*k1+w2*k2;
end
format short;