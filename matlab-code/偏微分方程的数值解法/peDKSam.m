function u = peDKSam(a,b,dt,n,minx,maxx,M)
format long;
h = (maxx-minx)/(n-1);
for j=1:(n+2*M)
    u0(j) = DKIniU(minx+(j-M-1)*h);
end 
u1 = u0;
coff = dt*b/(1+a*h/b/2);

for k=1:M
    for i=k+1:n+2*M-k
        u1(i) = coff*(u0(i+1)-2*u0(i)+u0(i-1))+a*dt*(u0(i)-u0(i-1))/h+u0(i);
    end
    u0 = u1;
end

u = u1((M+1):(M+n));
format short;