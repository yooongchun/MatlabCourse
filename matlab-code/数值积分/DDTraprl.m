function [I,step] = DDTraprl(f,a,b,eps)
if(nargin==3)
    eps=1.0e-4;
end;
n=0;
h=(b-a);
I2=(subs(sym(f),findsym(sym(f)),a)+subs(sym(f),findsym(sym(f)),b))/h/2;
tol=1;
while tol>eps
    n=n+1;
    h=h/2;                  %区间逐次分半
    I1=I2;
    I2=0;
    for i=0:(2^n-1)
        x=a+h*i;
        x1=x+h;
        I2=I2+(h/2)*(subs(sym(f),findsym(sym(f)),x)+...
            subs(sym(f),findsym(sym(f)),x1));        %梯形公式
    end
    tol=abs(I2-I1);
end

I=I2;
step=n;