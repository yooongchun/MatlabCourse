function u = peParabKN(c,dt,n,minx,maxx,lbu,rbu,M)
format long;
h = (maxx-minx)/(n-1);
u0(1) = lbu;
u0(n) = rbu;
for j=2:n-1
    u0(j) = PrIniU(minx+(j-1)*h);
end 
u1 = u0;

for k=1:M
    A = zeros(n-2,n-2);
    cb =  zeros(n-2,1);
    cb(1) = -u0(2) -(u0(3)-2*u0(2)+u0(1))*dt*c*lbu/h/h/2 - dt*c*lbu/h/h/2;
    cb(n-2) = -u0(n-1) -(u0(n)-2*u0(n-1)+u0(n-2))*dt*c*lbu/h/h/2 - dt*c*rbu/h/h/2;
    for i=2:n-3
        cb(i) = -u0(i+1) -(u0(i+2)-2*u0(i+1)+u0(i))*dt*c*lbu/h/h/2;
    end
    A(1,1) = -dt*c/h/h -1;
    A(1,2) = dt*c/h/h/2 ;
    for i=2:n-3
        A(i,i-1) = dt*c/h/h/2 ;
        A(i,i) = - dt*c/h/h -1 ;
        A(i,i+1) = dt*c/h/h/2  ;
    end
    A(n-2,n-2) = -dt*c/h/h -1;
    A(n-2,n-3) = dt*c/h/h/2;
    u1(2:(n-1)) = A\cb;
    u0 = u1;
end

u = u1;
format short;