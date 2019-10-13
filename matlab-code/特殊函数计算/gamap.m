function gp = gamap(x,alpha)
format long;
c = exp(-x)*power(x,alpha);
if x<alpha+1
    gp = c/exp(lngama(alpha+1));
    tol = 1;    
    i = 1;
    while tol == 1
        T1 = exp(lngama(alpha+1+i));
        dP = c*power(x,i)/T1;
        if dP/gp < 1.0e-20
            tol = 0;
        else
            gp = gp + dP;
        end
        i = i + 1;
    end
else
    tmp1 = gamafun(alpha);
    n = 10;
    while 1
        t1 = lfs(n,x,alpha);
        t2 = lfs(n+1,x,alpha);
        if abs(t2-t1)< 1.0e-20
            gp = 1 - c * t1/tmp1;
            break;
        else
            n = n + 1;
        end
    end        
end

function q = lfs(n,x,alpha)
format long;
q = n;
for i=n:-1:2
    q1 = x + (i-alpha)/(1 + q);
    q = 1 + (i-1)/q1;
end
q = x + (1-alpha)/q;
q = 1/q;

        