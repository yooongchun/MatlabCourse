function [F,G] =AccordAnalysis(X)
format long;
sz = size(X);
N = sz(1);         %样本个数
n = sz(2);

meanLC = mean(X);
meanLX = mean(transpose(X));
SumX = sum(sum(X));

for i=1:N
    for j=1:n
        z(i,j) =( X(i,j) - sqrt(meanLX(i)*meanLC(j)))/SumX;
    end
end

A = z*transpose(z);
[zA,m,lamda,U] = MainAnalysis(A);
V = transpose(U);

for i=1:n
    for j=1:m
        F(i,j) = U(i,j)*sqrt(lamda(j));
        G(i,j) = V(i,j)*sqrt(lamda(j));
    end
end