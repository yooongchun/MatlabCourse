function u = peRich(a,dt,n,minx,maxx,M)
format long;
h = (maxx-minx)/(n-1);
for j=1:(n+4*M)
        u0(j) = IniU(minx+(j-2*M-1)*h);
end 
u1 = u0;

for k=1:M
    for i=2*k+1:n+4*M-2*k
        tmpU1 = -dt*a*(u0(i+2)-u0(i))/h/4+(u0(i+2)+u0(i))/2;
        tmpU2 = -dt*a*(u0(i)-u0(i-2))/h/4+(u0(i)+u0(i-2))/2;        
        u1(i) = -dt*a*(tmpU1-tmpU2)/h/2+u0(i);
    end
    u0 = u1;
end

u = u1((2*M+1):(2*M+n));
format short;
    
         