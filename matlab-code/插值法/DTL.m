function fz = DTL(x,y,Z,x0,y0)
syms s t;
f = 0.0;
n = length(x);
m = length(y);

for i=1:n
    if(x(i)<=x0)&& (x(i+1)>=x0)
        index_x = i;
        break;
    end
end                          %找到x0所在区间
for i=1:m
    if(y(i)<=y0)&& (y(i+1)>=y0)
        index_y = i;
        break;
    end
end                          %找到y0所在区间

if index_x == 1
    cx(1:3) = index_x:(index_x+2);
else
    if index_x == n-1
        cx(1:3) = (index_x-1):(index_x+1);
    else
        if abs(x(index_x-1)-x0)>abs(x(index_x+2)-x0)
            cx(1:3) = (index_x):(index_x+2);
        else
            cx(1:3) = (index_x-1):(index_x+1);
        end
    end
end                        %找到离x0最近的三个x坐标

if index_y == 1
    cy(1:3) = index_y:(index_y+2);
else
    if index_y == m-1
        cy(1:3) = (index_y-1):(index_y+1);
    else
        if abs(y(index_y-1)-y0)>=abs(y(index_y+2)-y0)
            cy(1:3) = (index_y):(index_y+2);
        else
            cy(1:3) = (index_y-1):(index_y+1);
        end
    end
end                     %找到离y0最近的三个y坐标

for i=1:3        
    i1 = mod(i+1,3);
    if(i1 == 0) 
        i1 = 3;
    end
    i2 = mod(i+2,3);
    if(i2 == 0) 
        i2 = 3;
    end
    for j=1:3
       j1 = mod(j+1,3);
       if(j1 == 0) 
           j1 = 3;
       end
       j2 = mod(j+2,3);
       if(j2 == 0) 
           j2 = 3;
       end
       f = f+Z(cx(i),cy(j))*((t-x(cx(i1)))*(t-x(cx(i2)))/(x(cx(i))-x(cx(i1)))/(x(cx(i))-x(cx(i2))))* ...
             (s-y(cy(j1)))*(s-y(cy(j2)))/(y(cy(j))-y(cy(j1)))/(y(cy(j))-y(cy(j2)));
                   %插值多项式
    end
end
fz = subs(f,'[t s]',[x0 y0]);
