function [r,m]=mulNewtonSOR(F,x0,w,h,l,eps)
if nargin==5
    eps=1.0e-4;
end

n = length(x0);
J = zeros(n,n);
Fx = subs(F,findsym(F),x0);
for i=1:n
    x1 = x0;
    x1(i) = x1(i)+h(i);
    J(:,i) = (subs(F,findsym(F),x1)-Fx)/h(i);
end
D = diag(diag(J));
L = -tril(J-D);
U = -triu(J-D);
inD = inv(D-w*L);
H = inD*(D - w*D+w*L);;
Hm = eye(n,n);
for i=1:l-1
    Hm = Hm + power(H,i);
end
dr = w*Hm*inD*Fx;
r = transpose(x0)-dr;                               
m=1;
tol=1;
while tol>eps
    x0=r;   
    Fx = subs(F,findsym(F),x0);
    J = zeros(n,n);
    for i=1:n
        x1 = x0;
        x1(i) = x1(i)+h(i);
        J(:,i) = (subs(F,findsym(F),x1)-Fx)/h(i);
    end
    D = diag(diag(J));
    L = -tril(J-D);
    U = -triu(J-D);
    inD = inv(D-w*L);
    H = inD*(D - w*D+w*L);;
    Hm = eye(n,n);
    for i=1:l-1
        Hm = Hm + power(H,i);
    end
    dr = w*Hm*inD*Fx;   
    r = x0-dr;                                 %核心迭代公式
    tol=norm(r-x0);
    m=m+1;
    if(m>100000)                                              %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
end
