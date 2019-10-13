function [r,n]=mulNewton(F,x0,eps)
if nargin==2
    eps=1.0e-4;
end
x0 = transpose(x0);
Fx = subs(F,findsym(F),x0);
var = findsym(F);
dF = Jacobian(F,var);
dFx = subs(dF,findsym(dF),x0);
r=x0-inv(dFx)*Fx;
n=1;
tol=1;
while tol>eps
    x0=r;
    Fx = subs(F,findsym(F),x0);
    dFx = subs(dF,findsym(dF),x0);
    r=x0-inv(dFx)*Fx;                                 %核心迭代公式
    tol=norm(r-x0);
    n=n+1;
    if(n>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
