function f = Neville(x,y,x0)
syms t;

if(length(x) == length(y))
    n = length(x);
else
    disp('x和y的维数不相等！');
    return;
end

y1(1:n) = t;
for(i=1:n-1)   
    for(j=i+1:n)
        if(j==2)
            y1(j) = y(j)+(y(j)-y(j-1))/((t-x(j-i))/(t-x(j)))*(1-(y(j)-y(j-1))/y(j));
        else
            y1(j) = y(j)+(y(j)-y(j-1))/((t-x(j-i))/(t-x(j)))*(1-(y(j)-y(j-1))/(y(j)-y(j-2)));
        end
    end         
    y = y1;
    if(i==n-1)
        if(nargin == 3)
            f = subs(y(n-1),'t',x0);
        else
            f = vpa(y(n-1),6);
        end
    end
    
end


