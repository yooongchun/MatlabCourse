function y = Ellipint2(x,k)
%自变量的值：x
%积分参数：k
%自变量取x值时的第一类椭圆积分值：y

format long;
m = 2;
tol = 1;
while tol > 1.0e-6
    y1 = subEllip(x,k,m);
    y2 = subEllip(x,k,m*2);
    tol = abs(y1 - y2);
    m = m*2;
end
y = (y1+y2)/2;

function tmpS = subEllip(x,k,m)
syms t;
h = x/m;
tmpS = 0;
u = k*k;

for i=1:m
    f = (1-u*sin(t)*sin(t));
    tmpS = tmpS + IntGauss(f,h*i-h,h*i,5);
end
