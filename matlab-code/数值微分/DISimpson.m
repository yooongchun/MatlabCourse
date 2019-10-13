function df = DISimpson(X,Y,n,p)
if n < 5
    disp('n不能小于5!');
    return;
end

if p == 0
    disp('p不能等于0!');
    return;
end

h = X(2)-X(1);
xx =linspace(X(1),X(n),h);
if(xx ~= X)
    disp('节点之间不是等距的！');
    return;
end

f(1)=(Y(3)-Y(1))/(2*h);
f(2)=(Y(n)-Y(n-2))/(2*h);
b(1,1)=3*(Y(3)-Y(1))/h-f(1);
b(n-2,1)=3*(Y(n)-Y(n-2))/h-f(2);
for(i=2:n-3)
    b(i,1) = 3*(Y(i+2)-Y(i))/h;
end

for(i=1:n-2)
    for(j=1:n-2)
        if( (i == j+1) || (j == i+1))
             A(i,j) = 1;
        else if( i == j)
             A(i,j) = 4;
            end
        end
    end
end

[Q,R]=qr(A);
DF = R\(Q\b);

if( p == 1)
    df = f(1);
else
    df = DF(p-1);
end

