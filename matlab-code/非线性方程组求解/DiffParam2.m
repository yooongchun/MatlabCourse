function r=DiffParam2(F,x0,h,N)
%非线性方程组：f
%初始解：x0
%数值微分增量步大小：h
%雅可比迭代参量:l
%解的精度：eps
%求得的一组解：r
%迭代步数：n

x0 = transpose(x0);
n = length(x0);
ht = 1/N;
Fx0  = subs(F,findsym(F),x0);
J = zeros(n,n);
for i=1:n
    xt = x0;
    xt(i) = xt(i)+h(i);
    J(:,i) = (subs(F,findsym(F),xt)-Fx0)/h(i);
end
inJ = inv(J);
x1 = x0 - ht*inJ*Fx0;

for k=1:N
    x2 = x1 + (x1-x0)/2;
    Fx2  = subs(F,findsym(F),x2);
    J = zeros(n,n);
    for i=1:n
        xt = x2;
        xt(i) = xt(i)+h(i);
        J(:,i) = (subs(F,findsym(F),xt)-Fx2)/h(i);
    end
    inJ = inv(J);
    r = x1 - ht*inJ*Fx0;
    x0 = x1;
    x1 = r;
end