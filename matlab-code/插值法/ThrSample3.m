function [f,f0] = ThrSample3 (x,y,x0)
syms t;
f = 0.0;
f0 = 0.0;

if(length(x) == length(y))
    n = length(x);
else
    disp('x和y的维数不相等！');
    return;
end                  %维数检查

for i=1:n
    if(x(i)<=x0)&& (x(i+1)>=x0)
        index = i;
        break;
    end
end                          %找到x0所在区间

for i=1:n
    if(x(i)<=x0)&& (x(i+1)>=x0)
        index = i;
        break;
    end
end                          %找到x0所在区间
 
A = diag(2*ones(1,n-1));       %求解m的系数矩阵
h0 = x(2)-x(1);
h1 = x(3)–x(2);
he = x(n)-x(n-1);
A(1,2) = h0/(h0+h1);
A(1,n-1) = 1 - A(1,2);
A(n-1,1) = he/(h0+he);
A(n-1,n-2) = 1 - A(n-1,1);

c = zeros(n-1,1);
c(1) = 3* A(1,n-1)*(y(2)-y(1))/h0 + 3* A(1,2)*(y(3)-y(2))/h1;
for i=2:n-2
    u = (x(i)-x(i-1))/(x(i+1)-x(i-1));
    lamda = (x(i+1)-x(i))/(x(i+1)-x(i-1));
    c(i) = 3*lamda*(y(i)-y(i-1))/(x(i)-x(i-1))+ ...
        3*u*(y(i+1)-y(i))/(x(i+1)-x(i));
    A(i, i+1) = u;
    A(i, i-1) = lamda;    %形成系数矩阵及向量c
end
c(n-1) = 3*( he*(y(2)-y(1))/h0+h0*( y(n)-y(n-1))/he)/(h0+he);

m = zeros(n,1);
[m(2:n),Q,R] = qrxq(A,c);           %用qr分解法法求解方程组
m(1) = m(n);
h = x(index+1) - x(index);   %x0所在区间长度
f = y(index)*(2*(t-x(index))+h)*(t-x(index+1))^2/h/h/h + ...
        y(index+1)*(2*(x(index+1)-t)+h)*(t-x(index))^2/h/h/h + ...
        m(index)*(t-x(index))*(x(index+1)-t)^2/h/h - ...
        m(index+1)*(x(index+1)-t)*(t-x(index))^2/h/h;     
                            %x0所在区间的插值函数
f0 = subs(f,'t',x0);        %x0处的插值
