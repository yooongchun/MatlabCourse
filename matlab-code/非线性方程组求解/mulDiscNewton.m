function [r,m]=mulDiscNewton(F,x0,h,eps)
format long;
if nargin==3
    eps=1.0e-8;
end

n = length(x0);
fx = subs(F,findsym(F),x0);
J = zeros(n,n);
for i=1:n
    x1 = x0;
    x1(i) = x1(i)+h(i);
    J(:,i) = (subs(F,findsym(F),x1)-fx)/h(i);
end
r=transpose(x0)-inv(J)*fx;
m=1;
tol=1;
while tol>eps
    xs=r;
    fx = subs(F,findsym(F),xs);
    J = zeros(n,n);
    for i=1:n
        x1 = xs;
        x1(i) = x1(i)+h(i);
        J(:,i) = (subs(F,findsym(F),x1)-fx)/h(i);
    end
    r=xs-inv(J)*fx;                               %核心迭代公式
    tol=norm(r-xs);
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
format short;