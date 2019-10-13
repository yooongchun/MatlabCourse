function y = DEYCJZ_adms(f, h,a,b,y0,varvec,type)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0+h*Funval(f,varvec,[x(1) y(1)]);
for i=3:N+1
        v1 = Funval(f,varvec,[x(i-2) y(i-2)]);
        v2 = Funval(f,varvec,[x(i-1) y(i-1)]);
        t = y(i-1) + h*(3*v2-v1)/2;
        v3 = Funval(f,varvec,[x(i) t]);
        y(i) = y(i-1)+h*(v2+v3)/2;
end
format short;