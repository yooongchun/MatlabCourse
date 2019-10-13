function [x,L,U]= Doolittle (A,b)
N = size(A);
n = N(1);
L = eye(n,n);               %L的对角元素为1
U = zeros(n,n);

U(1,1:n) = A(1,1:n);        %U的第一行
L(1:n,1) = A(1:n,1)/U(1,1); %L的第一列

for k=2:n
    for i=k:n
        U(k,i) = A(k,i)-L(k,1:(k-1))*U(1:(k-1),i);
        %U的第k行
    end
    for j=(k+1):n
        L(j,k) = (A(j,k)-L(j,1:(k-1))*U(1:(k-1),k))/U(k,k);
        %L的第k列
    end
end

y = SolveDownTriangle(L,b);
x = SolveUpTriangle(U,y);    %求解方程
