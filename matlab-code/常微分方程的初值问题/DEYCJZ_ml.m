function y = DEYCJZ_ml(f,h,a,b,y0,varvec,type,s)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0+h*Funval(f,varvec,[x(1) y(1)]);
y(3) = y(2)+h*Funval(f,varvec,[x(2) y(2)]);
y(4) = y(3)+h*Funval(f,varvec,[x(3) y(3)]);

if type == 1
    for i=5:N+1
        v1 = Funval(f,varvec,[x(i-3) y(i-3)]);
        v2 = Funval(f,varvec,[x(i-2) y(i-2)]);
        v3 = Funval(f,varvec,[x(i-1) y(i-1)]);                
        t = y(i-4) + 4*h*(2*v3 - v2 + 2*v1)/3;
        for m=1:s
            ft = Funval(f,varvec,[x(i) t]);
            y(i) = y(i-2)+h*(4*v3 + v2 + ft)/3;
            t = y(i);
        end
    end
else
    p0 = 0;
    c = 0;
    for i = 5:N+1
        v1 = Funval(f,varvec,[x(i-3) y(i-3)]);
        v2 = Funval(f,varvec,[x(i-2) y(i-2)]);
        v3 = Funval(f,varvec,[x(i-1) y(i-1)]);                
        t = y(i-4) + 4*h*(2*v3 - v2 + 2*v1)/3;
        ft = Funval(f,varvec,[x(i) t]);
        p = y(i-4)+4*h*(2*v3 - v2 + 2*v1)/3;
        M = p - 28*(p0 - c)/29;
        F = Funval(f , varvec, [x(i) ,M]);
        c = y(i-2)+h*(4*v3 + v2 + F)/3;
        y(i) = c + ( p - c)/29;
        p0 = p;
    end
end
format short;