function f0 = BSample(a,b,n,y,y_1,y_N,x0)
f0 = 0.0;
h = (b-a)/n;
c = zeros(n+3,1);
b = zeros(n+1,1);

for i=0:n-1
    if(a+i*h<=x0) && (a+i*h+h>=x0)
        index = i;
        break;
    end
end                              %找到x0所在区间

A = diag(4*ones(n+1,1));
I = eye(n+1,n+1);
AL = [I(2:n+1,:);zeros(1,n+1)];
AU = [zeros(1,n+1);I(1:n,:)];
A = A+AL+AU;                      %形成系数矩阵
for i=2:n
    b(i,1) = 6*y(i);
end
b(1) = 6*y(1)+2*h*y_1;
b(n+1) = 6*y(n+1)-2*h*y_N;
d = followup(A,b);          %用追赶法求出系数
c(2:n+2) = d;
c(1) = c(2) - 2*h*y_1;      %c(-1)
c(n+3) = c(3)+2*h*y_N;      %c(n+1)

x1 = (a+index*h-h-x0)/h;
m1 = c(index+1)*(-((abs(x1))^3)/6+(x1)^2-2*abs(x1)+4/3);
x2 = (a+index*h-x0)/h;
m2 = c(index+2)*((abs(x2))^3/2-(x2)^2+2/3);
x3 = (a+index*h+h-x0)/h;
m3 = c(index+3)*((abs(x3))^3/2-(x3)^2+2/3);
x4 = (a+index*h+2*h-x0)/h;
m4 = c(index+4)*(-((abs(x4))^3)/6+(x4)^2-2*abs(x4)+4/3);
f0 = m1+m2+m3+m4;           %求出插值
