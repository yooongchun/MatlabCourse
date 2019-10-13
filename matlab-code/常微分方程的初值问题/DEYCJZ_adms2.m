function y = DEYCJZ_adms2(f, h,a,b,y0,varvec,type)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0+h*Funval(f,varvec,[x(1) y(1)]);
y(3) = y(2)+h*Funval(f,varvec,[x(2) y(2)]);
y(4) = y(3)+h*Funval(f,varvec,[x(3) y(3)]);

for i=5:N+1    
    v1 = Funval(f,varvec,[x(i-4) y(i-4)]);
    v2 = Funval(f,varvec,[x(i-3) y(i-3)]);
    v3 = Funval(f,varvec,[x(i-2) y(i-2)]);
    v4 = Funval(f,varvec,[x(i-1) y(i-1)]);
    t = y(i-1) + h*(55*v4 - 59*v3 + 37*v2 - 9*v1)/24;
    ft = Funval(f,varvec,[x(i) t]);
    y(i) = y(i-1)+h*(9*ft+19*v4-5*v3+v2)/24;
end
format short;