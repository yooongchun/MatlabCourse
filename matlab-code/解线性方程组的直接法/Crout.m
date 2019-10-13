function [x,L,U]=Crout(A,b)
N = size(A);
n = N(1);
L = zeros(n,n);
U = eye(n,n);              %U的对角元素为1

L(1:n,1) = A(1:n,1);       %L的第一列
U(1,1:n) = A(1,1:n)/L(1,1);  %U的第一行

for k=2:n
    for i=k:n
        L(i,k) = A(i,k)-L(i,1:(k-1))*U(1:(k-1),k); 
        %L的第k列
    end
    for j=(k+1):n
        U(k,j) = (A(k,j)-L(k,1:(k-1))*U(1:(k-1),j))/L(k,k);
        %U的第k行
    end
end

y = SolveDownTriangle(L,b);
x = SolveUpTriangle(U,y);        %求解方程
