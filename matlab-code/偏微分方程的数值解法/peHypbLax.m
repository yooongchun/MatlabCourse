function u = peHypbLax(a,dt,n,minx,maxx,M)
format long;
h = (maxx-minx)/(n-1);
for j=1:(n+2*M)
        u0(j) = IniU(minx+(j-M-1)*h);
end 
u1 = u0;

for k=1:M
    for i=k+1:n+2*M-k
        u1(i) = -dt*a*(u0(i+1)-u0(i-1))/h/2+(u0(i+1)+u0(i-1))/2;
    end
    u0 = u1;
end

u = u1((M+1):(M+n));
format short;
    
         