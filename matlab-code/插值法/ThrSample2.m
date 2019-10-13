function [f,f0] = ThrSample2 (x,y,y2_1, y2_N,x0)
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
 
A = diag(2*ones(1,n));       %求解m的系数矩阵
A(1,2) = 1;
A(n,n-1) = 1;
u = zeros(n-2,1);
lamda = zeros(n-1,1);
c = zeros(n,1);
for i=2:n-1
    u(i-1) = (x(i)-x(i-1))/(x(i+1)-x(i-1));
    lamda(i) = (x(i+1)-x(i))/(x(i+1)-x(i-1));
    c(i) = 3*lamda(i)*(y(i)-y(i-1))/(x(i)-x(i-1))+ ...
        3*u(i-1)*(y(i+1)-y(i))/(x(i+1)-x(i));
    A(i, i+1) = u(i-1);
    A(i, i-1) = lamda(i);    %形成系数矩阵及向量c
end
c(1) = 3*(y(2)-y(1))/(x(2)-x(1))-(x(2)-x(1))*y2_1/2;
c(n) = 3*(y(n)-y(n-1))/(x(n)-x(n-1))-(x(n)-x(n-1))*y2_N/2;

m = followup(A,c);           %用追赶法求解方程组
h = x(index+1) - x(index);   %x0所在区间长度
f = y(index)*(2*(t-x(index))+h)*(t-x(index+1))^2/h/h/h + ...
        y(index+1)*(2*(x(index+1)-t)+h)*(t-x(index))^2/h/h/h + ...
        m(index)*(t-x(index))*(x(index+1)-t)^2/h/h - ...
        m(index+1)*(x(index+1)-t)*(t-x(index))^2/h/h;     
                            %x0所在区间的插值函数
f0 = subs(f,'t',x0);        %x0处的插值
