function bp = betap(x,a,b)
%自变量的值：x
%第一个参数：a
%第二个参数：b
%自变量取x值时的不完全贝塔函数值：gp

format long;
if  a <=0 || b<=0 
    disp('a和b不能小于0!');
    return;
end

if  x == 0 || x == 1
    bp = 0;
end
    
c1 = power(x,a);
c2 = power(1-x,b);
c3 = Beta(a,b);

if x<((a+1)/(a+b+2))
    n = 1;
    while 1
        f1 = fi(2*n,x,a,b);
        f2 = fi(2*n+2,x,a,b);
        if abs(f2-f1)<1.0e-30
            bp  = f2*c1*c2/a/c3;
            break;
        else
            n = n + 1;
        end
    end       
else
    if x ==0.5 && a == b
        bp = 0.5;
    else
        n = 1;
        while 1
            f1 = fi(2*n,1-x,b,a);
            f2 = fi(2*n+2,1-x,b,a);
            if abs(f2-f1)<1.0e-30
                bp  = 1-f2*c1*c2/b/c3;
                break;
            else
                n = n + 1;
            end
        end       
    end
end

function F = fi(N,x,a,b)
format long;
n = N/2;
F = 0;
for i=n:-1:1
    tmpU = (a+2*i-1)*(a+2*i);
    s2 = i*(b - i)*x/tmpU;
    F1 = s2/(1+F);
    tmpV = (a+2*i-2)*(a+2*i-1);
    s1 = -(a+i-1)*(b+a+i-1)*x/tmpV;
    F = s1/(1+F1);
end
F = 1/(1+F);
