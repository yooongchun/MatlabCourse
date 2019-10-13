function r=DiffParam1(F,x0,h,N)
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

for k=1:N
    Fx  = subs(F,findsym(F),x0);
    J = zeros(n,n);
    for i=1:n
        x1 = x0;
        x1(i) = x1(i)+h(i);
        J(:,i) = (subs(F,findsym(F),x1)-Fx)/h(i);
    end
    inJ = inv(J);
    r = x0 - ht*inJ*Fx0;
    x0 = r;
end
    