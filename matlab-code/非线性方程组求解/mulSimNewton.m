function [r,n]=mulSimNewton(F,x0,eps) 
%非线性方程组：f
%初始解：a
%解的精度：eps
%求得的一组解：r
%迭代步数：n

if nargin==2
    eps=1.0e-6;
end

x0 = transpose(x0);
Fx = subs(F,findsym(F),x0);
dF = Jacobian(F);
c = subs(dF,findsym(dF),x0);
r=x0-inv(c)*Fx;
n=1;
tol=1;
while tol>eps
    x0=r;
    Fx = subs(F,findsym(F),x0);
    r=x0-inv(c)*Fx;                                 %核心迭代公式
    tol=norm(r-x0);
    n=n+1;
    if(n>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
