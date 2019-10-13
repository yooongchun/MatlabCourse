function [r,m]=mulDNewton(F,x0,eps) 
%非线性方程组：F
%初始解：x0
%解的精度：eps
%求得的一组解：r
%迭代步数：n

if nargin==2
    eps=1.0e-4;
end

x0 = transpose(x0);
dF = Jacobian(F);
m=1;
tol=1;
while tol>eps
    ttol=1;
    w=1;
    Fx = subs(F,findsym(F),x0);
    dFx = subs(dF,findsym(dF),x0);
    F1=norm(Fx);
    while ttol>=0                               %下面的循环是选取下山因子w的过程
        r=x0-w*inv(dFx)*Fx;                         %核心的迭代公式
        Fr = subs(F,findsym(F),r);
        ttol=norm(Fr)-F1;
        w=w/2;
    end
    tol=norm(r-x0);
    m=m+1;
    x0=r;
    if(m>100000)                                 %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
