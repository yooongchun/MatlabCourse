function [r,m]=mulGXF1(F,x0,x1,eps)
format long;
if nargin==3
    eps=1.0e-4;
end

x0 = transpose(x0);
x1 = transpose(x1);
n = length(x0);
fx = subs(F,findsym(F),x0);
fx1 = subs(F,findsym(F),x1);
h = x0 - x1;
J = zeros(n,n);
for i=1:n
    xt = x1;
    xt(i) = x0(i);
    J(:,i) = (subs(F,findsym(F),xt)-fx1)/h(i);
end
r=x1-inv(J)*fx1;
m=1;
tol=1;
while tol>eps    
    x0 = x1;
    x1 = r;
    fx = subs(F,findsym(F),x0);
    fx1 = subs(F,findsym(F),x1);
    h = x0 - x1;
    J = zeros(n,n);
    for i=1:n
        xt = x1;
        xt(i) = x0(i);
        J(:,i) = (subs(F,findsym(F),xt)-fx1)/h(i);
    end
    r=x1-inv(J)*fx1;    
    tol=norm(r-x1);
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
format short;