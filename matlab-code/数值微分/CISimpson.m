function df=CISimpson(func,x0,n,h)
if nargin == 2                      %以下是参数的判断过程
    h = 0.1;
    n = 5;
else
    if (nargin == 3 )
        if (n<5)
            disp('n不能小于5!');
            return;
        else
            h = 0.1;
        end
    else (nargin == 4 && h == 0.0)
        disp('h不能为0！');
        return;
    end
end

for(i=1:n)                        %这个循环计算节点的函数值
     if (mod(n,2) == 0)
        y(i)= subs(sym(func), findsym(sym(func)),x0+(i-n/2)*h);
    else
        y(i)= subs(sym(func), findsym(sym(func)),x0+(i-(n+1)/2)*h); 
     end
end

f(1)=(y(3)-y(1))/(2*h);
f(2)=(y(n)-y(n-2))/(2*h);           %这两行用中心微分法给出端点的导数

b(1:n-2,1) = zeros(n-2,1);
b(1,1)=3*(y(3)-y(1))/h-f(1);
b(n-2,1)=3*(y(n)-y(n-2))/h-f(2);   
for(i=2:(n-3))
    b(i,1) = 3*(y(i+2)-y(i))/h;
end                                %这一块是辛普森公式的右边的列向量

for(i=1:n-2)
    for(j=1:n-2)
        if( (i == j+1) || (j == i+1))
             A(i,j)= 1;
        else if( i == j)
             A(i,j) = 4;
            end
        end
    end
end                                %这一块是系数矩阵  

[Q,R]=qr(A);
DF = R\(Q\b);                      %用QR分解法求解

if( mod(n,2) == 0)
    df = DF(n/2);
else
    df = DF((n+1)/2);             
end                                %这里是求出x0处的导数值

