function [x,n]=conjgrad(A,b,x0)
if(nargin == 3)
    eps = 1.0e-6;
end

r1  = b-A*x0;
p1  = r1;
d   = dot(r1,r1)/dot(p1,A*p1);
x   = x0+d*p1;
r2  = r1-d*A*p1;
f   = dot(r2,r2)/dot(r1,r1);
p2  = r2+f*p1;
n   = 1;

for(i=1:(rank(A)-1))
    x0 = x;
    p1 = p2;
    r1 = r2;
    d  = dot(r1,r1)/dot(p1,A*p1);
    x  = x0+d*p1;
    r2 = r1-d*A*p1;
    f  = dot(r2,r2)/dot(r1,r1);
    p2 = r2+f*p1;
    n  = n + 1;
end

d  = dot(r2,r2)/dot(p2,A*p2);
x  = x+d*p2;
n  = n + 1;