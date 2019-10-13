function [x,n]=SOR(A,b,x0,w,M,eps)
%采用超松弛迭代法求线性方程组Ax=b的解
%线性方程组的系数矩阵：A
%线性方程组中的常数向量：b
%迭代初始向量：x0
%松弛因子：w
%解的精度控制：eps
%迭代步数控制：M
%线性方程组的解：x
%求出所需精度的解实际的迭代步数：n
if nargin==4
    eps= 1.0e-6;
    M  = 10000;
elseif nargin == 5
    eps  = 1.0e-6;
end      

if(w<=0 || w>=2)
    error;
    return;
end

D=diag(diag(A));    %求A的对角矩阵
L=-tril(A,-1);      %求A的下三角阵
U=-triu(A,1);       %求A的上三角阵
B=inv(D-L*w)*((1-w)*D+w*U);
f=w*inv((D-L*w))*b;
x=x0;
n=0;                  %迭代次数
tol=1;                %前后两次迭代结果误差
while tol>=eps
    x = B*x0+f;       %迭代公式
    n = n+1;
    tol = norm(x-x0);
    x0 = x;
    if(n>=M)
        disp('Warning: 迭代次数太多，可能不收敛！');
        return;
    end
end
