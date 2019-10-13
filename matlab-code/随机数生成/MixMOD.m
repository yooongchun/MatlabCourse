function r = MixMOD(x0,n,type)
format long;
M1 = power(2,31);
M2 = power(2,35);
a1 = 314159269;
a2 = power(5,15);
c1 = 453806245;
c2 = 1;
r = zeros(n,1);
x = zeros(n+1,1);
x(1) = x0;

if type == 1
    for i=2:n+1
        y = a1*x(i-1)+c1;
        x(i) = mod(y, M1);
        r(i-1) = x(i)/M1;
    end
else
    for i=2:n+1
        y = a2*x(i-1)+c2;
        x(i) = mod(y, M2);
        r(i-1) = x(i)/M2;
    end
end
format short;
