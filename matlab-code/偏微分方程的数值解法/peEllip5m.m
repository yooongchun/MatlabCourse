function u = peEllip5m(nx,minx,maxx,ny,miny,maxy)
format long;
hx = (maxx-minx)/(nx-1);
hy = (maxy-miny)/(ny-1);
u0 = zeros(nx,ny);
for j=1:ny
    u0(j,1) = EllIni2Uxl(minx,miny+(j-1)*hy);
    u0(j,nx) = EllIni2Uxr(maxx,miny+(j-1)*hy);
end
for j=1:nx
    u0(1,j) = EllIni2Uyl(minx+(j-1)*hx,miny);
    u0(ny,j) = EllIni2Uyr(minx+(j-1)*hx,maxy);
end 

A = -4*eye((nx-2)*(ny-2),(nx-2)*(ny-2));
b = zeros((nx-2)*(ny-2),1);
for i=1:(nx-2)*(ny-2)
    if mod(i,nx-2) == 1
        if i==1
            A(1,nx) = 1; 
            b(1) = - u0(1,1) - u0(3,1) - u0(1,3);
        else
            if i == (ny-3)*(nx-2)+1
                A(i,i-nx+1) = 1;
                b(i) = - u0(ny,1) - u0(ny,3) - u0(ny-2,1);
            else
                A(i,i-nx+3) = 1;
                A(i,i+nx-1) = 1;
                b(i) = - u0(floor(i/(nx-2))+1,1) - u0(floor(i/(nx-2))+3,1);
            end
        end
    else
        if mod(i,nx-2) == 0
            if i == nx-2
                A(i,i+nx-1) = 1;
                b(i) = - u0(1,nx-2) - u0(1,nx) - u0(3,nx);
            else
                if i == (ny-2)*(nx-2)
                    A(i,i-nx+1) = 1;
                    b(i) = - u0(ny,nx) - u0(ny,nx-2) - u0(ny-2,nx);
                else
                    A(i,i-nx+1) = 1;
                    A(i,i+nx-3) = 1;
                    b(i) = - u0(floor(i/(nx-2)),nx) - u0(floor(i/(nx-2))+2,nx);
                end
            end
        else
            if i>1 && i< nx-2
                A(i,i+nx-1) = 1;
                A(i,i+nx-3) = 1;
                b(i) = - u0(1,i) - u0(1,i+2);
            else
                if i > (ny-3)*(nx-2) && i < (ny-2)*(nx-2)
                    A(i,i-nx+3) = 1;
                    A(i,i-nx+1) = 1;
                    b(i) = - u0(ny,mod(i,(nx-2))) -u0(ny,mod(i,(nx-2))+2);
                else
                    A(i,i-nx+3) = 1;
                    A(i,i+nx-1) = 1;
                    A(i,i+nx-3) = 1;
                    A(i,i-nx+1) = 1;
                end
            end
        end
    end
end
ul = A\b;
for i=1:(ny-2)
    for j=1:(nx-2)
        u(i,j) = ul((i-1)*(nx-2)+j);
    end
end
format short;    
