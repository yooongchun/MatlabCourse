function f = Pade(y,n,x0)
syms t;

A = zeros(n,n);
q = zeros(n,1);
p = zeros(n+1,1);
b = zeros(n,1);
yy = 0;
a(1:2*n) = 0.0;

for(i=1:2*n)
    yy = diff(sym(y),findsym(sym(y)),n);
    a(i) = subs(sym(yy), findsym(sym(yy)), 0.0)/factorial(i);
end;

for(i=1:n)
    for(j=1:n)
        A(i,j)=a(i+j-1);
    end;
    b(i,1) = -a(n+i);
end;

q = A\b;
p(1) = subs(sym(y),findsym(sym(y)),0.0);
for(i=1:n)
    p(i+1) = a(n)+q(i)*subs(sym(y),findsym(sym(y)),0.0);
    for(j=2:i-1)
        p(i+1)=p(i+1)+q(j)*a(i-j);
    end
end

f_1 = 0;
f_2 = 1;
for(i=1:n+1)
    f_1 = f_1 + p(i)*(t^(i-1));
end

for(i=1:n)
    f_2 = f_2 + q(i)*(t^i);
end

if(nargin == 3)
    f = f_1/f_2;
    f = subs(f,'t',x0);
else
    f = f_1/f_2;
    f = vpa(f,6);
end
