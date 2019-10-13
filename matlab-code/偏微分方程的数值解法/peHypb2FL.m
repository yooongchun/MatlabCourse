function u = pe2FL(a,b,dt,nx,minx,maxx,ny,miny,maxy,M)
%½üËÆ·ÖÁÑ
format long;
hx = (maxx-minx)/(nx-1);
hy = (maxy-miny)/(ny-1);
for i=1:nx+4*M
    for j=1:(ny+4*M)
        u0(i,j) = Ini2U(minx+(i-2*M-1)*hx,miny+(j-2*M-1)*hy);
    end
end 
u1 = u0;

for k=1:M
    for i=2*k+1:nx+4*M-2*k
        for j=2*k-1:ny+4*M-2*k+2
            tmpU(i,j) =  u0(i,j) - a*dt*(u0(i+1,j)-u0(i-1,j))/2/hx + ...
                (a*dt/hx)^2*(u0(i+1,j)-2*u0(i,j)+u0(i-1,j))/2;
        end
    end

    for i=2*k+1:nx+4*M-2*k
        for j=2*k+1:nx+4*M-2*k
            u1(i,j) = tmpU(i,j) - b*dt*(tmpU(i,j+1)-tmpU(i,j-1))/2/hy + ...
                (b*dt/hy)^2*(tmpU(i,j+1)-2*tmpU(i,j)+tmpU(i,j-1))/2;
        end
    end
    u0 = u1;
end

u = u1((2*M+1):(2*M+nx),(2*M+1):(2*M+ny));
format short;      
         