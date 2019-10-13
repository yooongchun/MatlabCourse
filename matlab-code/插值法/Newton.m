function f = Newton(x,y,x0)
syms t;

if(length(x) == length(y))
    n = length(x);
    c(1:n) = 0.0;
else
    disp('x和y的维数不相等！');
    return;
end

f = y(1);
y1 = 0;
l  = 1;
 
for(i=1:n-1)   
    for(j=i+1:n)
        y1(j) = (y(j)-y(i))/(x(j)-x(i));
    end
    c(i) = y1(i+1);     
    l = l*(t-x(i));  
    f = f + c(i)*l;
    simplify(f);
    y = y1;
    
    if(i==n-1)
        if(nargin == 3)
            f = subs(f,'t',x0);
        else
            f = collect(f);                %将插值多项式展开
            f = vpa(f, 6);
        end
    end
end



