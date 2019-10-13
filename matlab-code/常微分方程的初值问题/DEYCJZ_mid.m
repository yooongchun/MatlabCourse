function y = DEYCJZ_mid(f, h,a,b,y0,varvec,type,s)
format long;
N = (b-a)/h;
y = zeros(N+1,1);
x = a:h:b;
y(1) = y0;
y(2) = y0+h*Funval(f,varvec,[x(1) y(1)]);
var = findsym(f);
if type == 1
    for i=3:N+1
        v1 = Funval(f,varvec,[x(i-1) y(i-1)]);
        t = y(i-2) + 2*h*v1;
        v2 = Funval(f,varvec,[x(i) t]);
        y(i) = y(i-1)+h*(v1+v2)/2;
    end
else
    if type == 2
        for i=3:N+1
            v1 = Funval(f,varvec,[x(i-1) y(i-1)]);                
            t = y(i-2) + 2*h*v1;
            v2 = Funval(f,varvec,[x(i) t]);
            for l=1:s
                y(i) = y(i-1)+h*(v2 + v1)/2;
                v2 = Funval(f,varvec,[x(i) y(i)]);
            end
        end
    else
        p0 = 0;
        c = 0;
        fnl = Funval(f,varvec,[x(1) y(1)]);
        for i = 3:N+1
            v1 = Funval(f,varvec,[x(i-1) y(i-1)]);
            p = y(i-2)+2*h*v1;
            M = p - 0.8*(p0 - c);
            F = Funval(f , varvec, [x(i) ,M]);
            fn = y(i-1) + h*(fnl + F)/2;
            y(i) = fn - 0.2*( p - fn);
            c = fn;
            fnl = fn;
            p0 = p;
        end
    end
end
format short;