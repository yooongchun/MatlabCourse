function u = peBW(a,dt,n,minx,maxx,M)
format long;
h = (maxx-minx)/(n-1);
for j=1:(n+2*M)
        u0(j) = IniU(minx+(j-2*M-1)*h);
end 
u1 = u0;

for k=1:M
    for i=2*k+1:n+2*M
        u1(i) = u0(i)-dt*a*(u0(i)-u0(i-1))/h-a*dt*(1-a*dt/h)* ...
            (u0(i)-2*u0(i-1)+u0(i-2))/2/h;
    end
    u0 = u1;
end

u = u1((2*M+1):(2*M+n));
format short;
    
         