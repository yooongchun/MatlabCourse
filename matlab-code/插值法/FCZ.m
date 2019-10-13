function [f,x0] = FCZ(x,y,y0)
syms t;
if(length(x) == length(y))
    n = length(x);
    c(1:n) = 0.0;
else
    disp('x和y的维数不相等！');
    return;
end

c(1) = x(1);
y1 = x;
for(i=1:n-1)   
    for(j=i+1:n)
        y2(j) = (y1(j)-y1(i))/(y(j)-y(i));
    end
    c(i+1) = y2(i+1);     
    y1 = y2;   
end

f = c(1);
for(i=1:n-1)
    ff = c(i+1);
    for(j=1:i)
        ff = ff*(t-y(j));
    end
    f = f + ff;
end;       
x0 = subs(f,'t',y0);
