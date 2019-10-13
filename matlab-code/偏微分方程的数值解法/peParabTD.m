function u = peParabTD(c,dt,n,minx,maxx,M)
%Ìøµã
format long;
h = (maxx-minx)/(n-1);
for j=1:(n+2*M)
    u0(j) = PrIniU(minx+(j-M-1)*h);
end 
u1 = u0;

for k=1:M
    for i=k+1:n+2*M-k
        if mod(n+i,2) == 0
            u1(i) = u0(i) + c*dt*(u0(i+1) - 2*u0(i) + u0(i-1))/h/h;
            if i > 2
               u1(i-1) =(u0(i-1) + c*dt*(u1(i) + u1(i-2))/h/h)/(1 + 2*c*dt/h/h);
            end
        end 
    end
    u0 = u1;
end

u = u1((M+1):(M+n));
format short;