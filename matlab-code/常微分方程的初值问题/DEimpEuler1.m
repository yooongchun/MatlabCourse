function y = DEimpEuler1(f, h,a,b,y0)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b-h;
y(1) = y0;
var = findsym(f);
yd = diff(f,var(4));
for i=2:N+1
    fx = f - yd*var(4);
    dfy = subs(yd,findsym(yd),x(i-1));
    cx = subs(fx,findsym(fx),x(i-1));
    y(i) = (y(i-1)+h*cx)/(1-h*dfy);
end
format short;