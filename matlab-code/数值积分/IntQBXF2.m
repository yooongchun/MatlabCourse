function q = IntQBXF2(func,n)
format long;
pi = 3.1415926535;
q = 0;
A = zeros(n,1);
x = zeros(n,1);
for i=1:n
    A(i) = sin((i*pi)/(n+1))*sin((i*pi)/(n+1))*pi/(n+1);
    x(i) = cos(pi*i/(n+1));
    y(i) = subs(sym(func), findsym(sym(func)), x(i));
    q = q + A(i)*y(i);
end
