function fz = DL(x,y,Z,x0,y0,eps)
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

A = [1 x(index_x) y(index_y) x(index_x)* y(index_y);
      1 x(index_x+1) y(index_y+1) x(index_x+1)* y(index_y+1);
      1 x(index_x) y(index_y+1) x(index_x)* y(index_y+1);
      1 x(index_x+1) y(index_y) x(index_x+1)* y(index_y)];
iA = inv(A);
B = iA*[Z(index_x,index_y); Z(index_x+1,index_y+1); Z(index_x,index_y+1);
            Z(index_x+1,index_y)];
fz = [1 x0 y0 x0*y0]*B;
