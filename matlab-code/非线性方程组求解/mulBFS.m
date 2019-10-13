function [r,n]=mulBFS(F,x0,B,eps)
if nargin==2
    l = length(x0);
    B=eye(l);                             %B取为单位阵
    eps=1.0e-4;
else
   if nargin==3
         eps=1.0e-4;
    end
end

fx = subs(F,findsym(F),x0);
r=transpose(x0)-B*fx;
n=1;
tol=1;
while tol>eps
    x0=r;
    fx = subs(F,findsym(F),x0);
    r=x0-B*fx;
    y=r-x0;
    fr = subs(F,findsym(F),r);
    z = fr-fx;
    u = 1 + z'*B*z/(y'*z);
    B1= B+ (u*y*y'-B*z*y'-y*z'*B)/(y'*z);                   %调整B
    B=B1;
    n=n+1;
    if(n>100000)                                   %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
    tol=norm(r-x0);
end
