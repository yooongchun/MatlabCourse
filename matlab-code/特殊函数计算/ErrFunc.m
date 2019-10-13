function erf = ErrFunc(x)
format long;
pi = 3.1415926535;
m = 1;
tol = 1;
while tol > 1.0e-6
    s1 = subERF(x,m);
    s2 = subERF(x,m+1);
    tol = abs(s1 - s2);
    m = m*2;
end
erf = (s1+s2)/sqrt(pi);

function tmpF = subERF(x,m)
syms t;
h = x/m;
tmpF = 0;

for i=1:m
    tmpF = tmpF + IntGauss('exp(-t*t)',h*i-h,h*i,5);
end
    