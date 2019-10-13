function y = DEEuler(f, h,a,b,y0,varvec)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
for i=2:N+1
    y(i) = y(i-1)+h*Funval(f,varvec,[x(i-1), y(i-1)]);
end
format short;