function [r,m]=mulConj(F,x0,h,eps)
format long;
if nargin==3
    eps=1.0e-6;
end

n = length(x0);
x0 = transpose(x0);
fx0 = subs(F,findsym(F),x0);
p0 = zeros(n,n);
for i=1:n
    x1 = x0;
    x1(i) = x1(i)*(1+h);
    p0(:,i) = -(subs(F,findsym(F),x1)-fx0)/h;
end
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
    lamda = fx/sum(diag(transpose(J)*J));
    r=x0+p0*lamda;  %核心迭代公式
    
    fr = subs(F,findsym(F),r);
    Jnext = zeros(n,n);
    for i=1:n
        x1 = r;
        x1(i) = x1(i)+h;
        Jnext(:,i) = (subs(F,findsym(F),x1)-fr)/h;
    end    
    abs1 = transpose(Jnext)*Jnext;
    abs2 = transpose(J)*J;
    v = abs1/abs2;
    if (abs(det(v)) < 1)
        p1 = -Jnext+p0*v;
    else
        p1 = -Jnext;
    end
    tol=norm(r-x0);
    p0 = p1;
    x0 = r;
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
format short;