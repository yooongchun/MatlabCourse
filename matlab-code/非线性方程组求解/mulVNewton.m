function [r,m]=mulVNewton(F,x0,A,eps) 
%方程组：F
%方程组的初始解：x0
% 初始A矩阵：A
%解的精度：eps
%求得的一组解：r
%迭代步数：m

if nargin==2
    A=eye(length(x0)); %A取为单位阵
    eps=1.0e-4;
else
   if nargin==3
         eps=1.0e-4;
   end
end

x0 = transpose(x0);
Fx = subs(F, findsym(F),x0);
r=x0-A\Fx;
m=1;
tol=1;
while tol>eps
    x0=r;
    Fx = subs(F, findsym(F),x0);
    r=x0-A\Fx;
    y=r-x0;
    Fr = subs(F, findsym(F),r);
    z= Fr-Fx;
    A1=A+(z-A*y)*transpose(y)/norm(y);                   %调整A
    A=A1;
    m=m+1;
    if(m>100000)                                   %迭代步数控制
        disp('迭代步数太多，可能不收敛！');
        return;
    end
    tol=norm(r-x0);
end
