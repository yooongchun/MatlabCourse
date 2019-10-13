function [I,step] = CombineTraprl(f,a,b,eps)
%f    被积函数
%a,b  积分上下限
%eps  精度
%I    积分结果
%step 积分的子区间数
if(nargin ==3)
    eps=1.0e-4;
end

n=1;
h=(b-a)/2;
I1=0;
I2=(subs(sym(f),findsym(sym(f)),a)+subs(sym(f),findsym(sym(f)),b))/h;
while abs(I2-I1)>eps
    n=n+1;  
    h=(b-a)/n;
    I1=I2;
    I2=0;
    for i=0:n-1
        x=a+h*i;
        x1=x+h;
        I2=I2+(h/2)*(subs(sym(f),findsym(sym(f)),x)+subs(sym(f),findsym(sym(f)),x1));
    end
end

I=I2;
step=n;

    