function [I,step] = DDSimpson(f,a,b,eps)
if(nargin==3)
    eps=1.0e-4;
end;
n=1;
h=b-a;
I1=0;
I2=(subs(sym(f),findsym(sym(f)),a)+...
    subs(sym(f),findsym(sym(f)),b))/h/2;
tol=1;
while tol>eps
    n=n+1;
    h=h/2;
    I1=I2;
    I2=0;
    for i=0:(2^(n-1)-1)
        x=a+h*2*i;
        x1=x+h;
        x2=x1+h;
        I2=I2+(h/3)*(subs(sym(f),findsym(sym(f)),x)+...
            4*subs(sym(f),findsym(sym(f)),x1)+...
            subs(sym(f),findsym(sym(f)),x2));
    end
    tol=abs(I2-I1);
end
I=I2;
step=n;