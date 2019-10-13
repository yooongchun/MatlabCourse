function [x,n]=JOR(A,b,x0,w,eps,M)
if nargin==4
    eps= 1.0e-6;
    M  = 10000;
elseif nargin ==5
    M  = 10000;
end  
if(w<=0 || w>=2)     %收敛条件要求
    error;
    return;
end
D=diag(diag(A));    %求A的对角矩阵
B=w*inv(D);
%迭代过程
x=x0;
n=0;                                      %迭代次数
tol=1;
%迭代过程
while tol>=eps
    x=x0-B*(A*x0-b);
    n  = n+1;
    tol = norm(x-x0);
    x0 = x;
    if(n>=M)
        disp('Warning: 迭代次数太多，可能不收敛！');
        return;
    end
end
