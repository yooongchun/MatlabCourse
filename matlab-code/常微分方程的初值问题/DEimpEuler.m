function y = DEimpEuler(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
y(1) = y0;
x = a:h:b;
var = findsym(f);
for i=2:N+1
   fx = Funval(f,var(1),x(i));
   gx = y(i-1)+h*fx - varvec(2);
   y(i) = NewtonRoot(gx,-10,10,eps);
end
format short;
