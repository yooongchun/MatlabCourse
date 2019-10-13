function r = PFQZ(k,x0,n)
r = zeros(n,1);
x = zeros(n,1);
x(1) = x0;
r(1) = x(1)/(100^k);

for i=2:n
    x(i) = mod(x(i-1)^2 /(10^k),100^k);
    r(i) = x(i)/(100^k);
end