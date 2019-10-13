function u = pe2LF(a,b,dt,nx,minx,maxx,ny,miny,maxy,M)
%À²-·ð
format long;
hx = (maxx-minx)/(nx-1);
hy = (maxy-miny)/(ny-1);
for i=1:nx+2*M
    for j=1:(ny+2*M)
        u0(i,j) = Ini2U(minx+(i-M-1)*hx,miny+(j-M-1)*hy);
    end
end 
u1 = u0;

for k=1:M
    for i=k+1:nx+2*M-k
        for j=k+1:ny+2*M-k
            u1(i,j) = (u0(i+1,j)+u0(i-1,j)+u0(i,j+1)+u0(i,j-1))/4 ...
                 -a*dt*(u0(i+1,j)-u0(i-1,j))/2/hx ...
                 -b*dt*(u0(i,j+1)-u0(i,j-1))/2/hy;
        end
    end
    u0 = u1;
end

u = u1((M+1):(M+nx),(M+1):(M+ny));
format short;    
         