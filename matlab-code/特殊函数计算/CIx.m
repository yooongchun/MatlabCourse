function ci = CIx(x)
format long;
r = 0.57721566490153286060651;
ci = r + log(x);
m = 1;
tol = 1;
while tol > 1.0e-6
    c1 = subCIx(x,m);
    c2 = subCIx(x,m+1);
    tol = abs(c1 - c2);
    m = m*2;
end
ci = ci - (c1+c2)/2;

function tmpC = subCIx(x,m)
syms t;
h = x/m;
tmpC = 0;

for i=1:m
    tmpC = tmpC + IntGauss('(1-cos(t))/t',h*i-h,h*i,5);
end