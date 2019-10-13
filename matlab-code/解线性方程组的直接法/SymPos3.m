function [x,L,D]= SymPos3 (A,b)
N = size(A);
n = N(1);
L = eye(n,n);           %L的对角元素为1
d = zeros(n,1);
AA = zeros(n,n);        %保存的中间变量

for k=1:n 
    d(k,1) = A(k,k)-AA(k,1:(k-1))*transpose(L(k,1:(k-1)));
    %D的第k个对角元素
    for i=(k+1):n
        AA(i,k) = A(i,k)-AA(i,1:(k-1))*transpose(L(k,1:(k-1))); 
        %AA的第k列
        L(i,k) = AA(i,k)/d(k,1);
        %L的第k列
    end
end

D = diag(d);
y = SolveDownTriangle(L,b);              %求解y
for i=1:n
    y(i,1)=y(i,1)/d(i,1);
end
x = SolveUpTriangle(transpose(L),y);     %求解x
