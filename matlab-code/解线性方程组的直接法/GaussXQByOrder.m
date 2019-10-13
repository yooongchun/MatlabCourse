function [x,XA]=GaussXQByOrder(A,b)
N = size(A);
n = N(1);

for i=1:(n-1)
    for j=(i+1):n
        if(A(i,i)==0)
            disp('对角元素为0！');            %防止对角元素为0
            return;
        end
        l = A(j,i);
        m = A(i,i);
        A(j,1:n)=A(j,1:n)-l*A(i,1:n)/m;   %消元方程
        b(j)=b(j)-l*b(i)/m;
    end
end

x=SolveUpTriangle(A,b);                      %通用的求上三角系数矩阵线性方程组的函数
XA = A;                                           %消元后的系数矩阵
