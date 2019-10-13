function r = MulMOD2(L,s,x0,n)
r = zeros(n,1);
x = zeros(n,1);
M = power(2,L);
a = power(5,2*s+1);
x(1) = x0;
r(1) = x(1)/M;

for i=2:n
    y = a*x(i-1);
    x(i) = mod(y,M);
    r(i) = x(i)/M;
end