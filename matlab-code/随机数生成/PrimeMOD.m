function r = PrimeMOD(x0,n,type)
format long;
M1 = power(2,35)-31;
M2 = power(2,31)-1;
a1 = 3125;
a2 = 16807;
r = zeros(n,1);
x = zeros(n+5,1);
x(1) = x0;

if type == 1
    for i=2:n+5
        y = a1*x(i-1);
        x(i) = mod(y, M1);
    end
    r = x(6:(n+5))/M1;
else
    for i=2:n+5
        y = a2*x(i-1);
        x(i) = mod(y, M2);
    end
    r = x(6:(n+5))/M2;
end
format short;