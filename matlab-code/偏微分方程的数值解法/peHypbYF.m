function u = peYF(a,dt,n,minx,maxx,M)
format long;
h = (maxx-minx)/(n-1);
if a>0
    for j=1:(n+M)
        u0(j) = IniU(minx+(j-M-1)*h);
    end
else   
    for j=1:(n+M)
        u0(j) = IniU(minx+(j-1)*h);
    end
end   
u1 = u0;

for k=1:M
    if a>0 
        for i=(k+1):n+M
            u1(i) = -dt*a*(u0(i)-u0(i-1))/h+u0(i);
        end
    else
        for i=1:n+M-k
            u1(i) = -dt*a*(u0(i+1)-u0(i))/h+u0(i);
        end
    end
    u0 = u1;
end
if a>0
    u = u1((M+1):M+n);
else
    u = u1(1:n);
end
format long;
    
         