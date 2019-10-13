function [I,step] = DDBuer(f,a,b,eps)
if(nargin==3)
    eps=1.0e-4;
end;
n=1;
h=b-a;
I1=0;
I2=(subs(sym(f),findsym(sym(f)),a)+subs(sym(f),findsym(sym(f)),b))/h/2;
tol=1;
while tol>eps
    n=n+1;
    h=h/4;
    I1=I2;
    I2=0;
    for i=0:(4^(n-1)-1)
        x=a+h*4*i;
        x1=x+h;
        x2=x1+h;
        x3=x2+h;
        x4=x3+h;
        I2=I2+(2*h/45)*(7*subs(sym(f),findsym(sym(f)),x)+...
            32*subs(sym(f),findsym(sym(f)),x1)+...
            12*subs(sym(f),findsym(sym(f)),x2)+...
            32*subs(sym(f),findsym(sym(f)),x3)+...
            7*subs(sym(f),findsym(sym(f)),x4));
    end
    tol=abs(I2-I1);
end
I=I2;
step=n;