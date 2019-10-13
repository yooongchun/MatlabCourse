function [r,m]=mulGSND(F,x0,h,eps)
format long;
if nargin==3
    eps=1.0e-8;
end

n = length(x0);
x0 = transpose(x0);
m=1;
tol=1;
while tol>eps
    fx = subs(F,findsym(F),x0);
    J = zeros(n,n);
    for i=1:n
        x1 = x0;
        x1(i) = x1(i)+h;
        J(:,i) = (subs(F,findsym(F),x1)-fx)/h;
    end
    DF = inv(transpose(J)*J)*transpose(J);
    r=x0-DF*fx;  %核心迭代公式
    tol=norm(r-x0);
    x0 = r;
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
format short;