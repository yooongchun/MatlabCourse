function [x,n]= preconjgrad (A,b,x0,M,eps)
if nargin == 4
    eps = 1.0e-6;
end
r1 = b-A*x0;
iM = inv(M);
z1 = iM*r1; 
p  = z1;
n  = 0;
tol= 1;
while tol>=eps
    alpha  = dot(r1,z1)/dot(p,A*p);     
    x  = x0 + alpha*p;
    r2 = r1 - alpha*A*p;
    z2 = iM*r2;
    belta  = dot(r2,z2)/dot(r1,z1);
    p  = z2+belta*p;
    n  = n + 1;
    tol = norm(x-x0);
    x0 = x;                       %更新迭代值
    r1 = r2;
    z1 = z2;
end
