function ei = EIx(x)
format long;
r = 0.57721566490153286060651;
ei = r + log(x);
m = 1;
tol = 1;
while tol > 1.0e-6
    e1 = subEIx(x,m);
    e2 = subEIx(x,m+1);
    tol = abs(e1 - e2);
    m = m*2;
end
ei = ei - (e1+e2)/2;

function tmpE = subEIx(x,m)
syms t;
h = x/m;
tmpE = 0;

for i=1:m
    tmpE = tmpE + IntGauss('(1-exp(-t))/t',h*i-h,h*i,5);
end