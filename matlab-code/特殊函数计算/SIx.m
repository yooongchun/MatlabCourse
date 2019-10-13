function si = SIx(x)
format long;
m = 1;
tol = 1;
while tol > 1.0e-6
    s1 = subSIx(x,m);
    s2 = subSIx(x,m+1);
    tol = abs(s1 - s2);
    m = m*2;
end
si = (s1+s2)/2;

function tmpS = subSIx(x,m)
syms t;
h = x/m;
tmpS = 0;

for i=1:m
    tmpS = tmpS + IntGauss('sin(t)/t',h*i-h,h*i,5);
end
    