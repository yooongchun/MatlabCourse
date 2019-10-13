function x=YSNewton(a)
format long;
n = length(a);
max_X = BenvliMAX(a);
b = zeros(n,1);
x = zeros(n,1);
syms t real;
f = power(t,n);
m = 0:n-1;
s = power(t,m);
f = f + dot(s, a(n:-1:1));

for k=1:n
    x(k) = NewtonRoot(f,-max_X,max_X);
    b = 0;
    b(1) = 1;
    for i=2:n-k+1
        b(i) = a(i-1) + x(k)*b(i-1);
    end
    m = 0:n-k;
    s = power(t,m);
    f = dot(s, b(n-k+1:-1:1));
    a = b(2:length(b));
end
format short;
