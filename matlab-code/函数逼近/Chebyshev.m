function f = Chebyshev(y,k,x0)
syms t;
T(1:k+1) = t;
T(1) = 1;
T(2) = t;
c(1:k+1) = 0.0;

c(1)=int(subs(y,findsym(sym(y)),sym('t'))*T(1)/sqrt(1-t^2),t,-1,1)/pi;
c(2)=2*int(subs(y,findsym(sym(y)),sym('t'))*T(2)/sqrt(1-t^2),t,-1,1)/pi;
f = c(1)+c(2)*t;

for i=3:k+1
    T(i) = 2*t*T(i-1)-T(i-2);
    c(i) = 2*int(subs(y,findsym(sym(y)),sym('t'))*T(i)/sqrt(1-t^2),t,-1,1)/2;
    f = f + c(i)*T(i);
    f = vpa(f,6);
    
    if(i==k+1)
        if(nargin == 3)
            f = subs(f,'t',x0);
        else
            f = vpa(f,6);
        end
    end
end