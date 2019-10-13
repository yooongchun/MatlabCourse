function [x,n]= fastdown(A,b,x0,eps)
if(nargin == 3)
    eps = 1.0e-6;
end

x=x0;
n=0;
tol=1;
while(tol>eps)                       %以下过程可参考算法流程
    r  = b-A*x0;
    d  = dot(r,r)/dot(A*r,r);
    x  = x0+d*r;
    tol = norm(x-x0);
    x0 = x;
    n  = n + 1;
end
