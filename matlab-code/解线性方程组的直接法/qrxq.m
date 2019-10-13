function [x,Q,R]=qrxq(A,b) 
N = size(A);
n = N(1);
B = A;                        %保存系数矩阵

A(1:n,1)=A(1:n,1)/norm(A(1:n,1)); %将A的第一列正规化
for i=2:n
    for j=1:(i-1)
        A(1:n,i)= A(1:n,i)-dot(A(1:n,i),A(1:n,j))*A(1:n,j); 
        %使A的第i列与前面所有的列正交
    end
    A(1:n,i)=A(1:n,i)/norm(A(1:n,i));
    %将A的第i列正规化
end
Q = A;                               %分解出来的正交矩阵
R = transpose(Q)*B;
x=SolveUpTriangle(R,transpose(Q)*b);  %求解方程
