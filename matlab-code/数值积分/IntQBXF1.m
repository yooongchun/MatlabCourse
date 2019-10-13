function q = IntQBXF1(func,n)
format long;
pi = 3.1415926535;
q = 0;
A = zeros(n,1);
x = zeros(n,1);
for i=1:n
    A(i) = pi/n;
    x(i) = cos(pi*(2*i-1)/2/n);
    y(i) = subs(sym(func), findsym(sym(func)), x(i));
    q = q + A(i)*y(i);
end
