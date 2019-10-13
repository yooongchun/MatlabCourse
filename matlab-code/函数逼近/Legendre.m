function f = Legendre(y,k,x0)
syms t;
P(1:k+1) = t;
P(1) = 1;
P(2) = t;
c(1:k+1) = 0.0;

c(1)=int(subs(y,findsym(sym(y)),sym('t'))*P(1),t,-1,1)/2;
c(2)=int(subs(y,findsym(sym(y)),sym('t'))*P(2),t,-1,1)/2;
f = c(1)+c(2)*t;

for i=3:k+1
    P(i) = ((2*i-3)*P(i-1)*t-(i-2)*P(i-2))/(i-1);
    c(i) = int(subs(y,findsym(sym(y)),t)*P(i),t,-1,1)/2;
    f = f + c(i)*P(i);
    
    if(i==k+1)
        if(nargin == 3)
            f = subs(f,'t',x0);
        else
            f = vpa(f,6);
        end
    end
end