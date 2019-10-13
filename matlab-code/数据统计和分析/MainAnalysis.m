function [Z,m,lamda,U] = MainAnalysis(X)
format long;
sz = size(X);
N = sz(1);         %样本个数
n = sz(2);

meanX = mean(X);
sx = zeros(n,1);
Y = zeros(N,n);
for i=1:n
    sx(i) = sqrt(dot(X(1:N,i)-meanX(i)*ones(N,1),X(1:N,i)-meanX(i)*ones(N,1)))/sqrt(N-1);
end

for j=1:n
    Y(:,j) = (X(:,j) - meanX(j)*ones(N,1))/sx(j);
end

for i=1:n
    for j=1:n
        r(i,j) = dot(Y(:,i),Y(:,j))/(N-1);
    end
end

[v,e] = eig(r);
[sortE,turnV] = sort(diag(e),'descend');
Esum = sortE(1);
Tr = sum(diag(r));
m = 1;
while 1
    if Esum/Tr > 0.85
        break;
    else
        m = m+1;
        Esum = Esum + sortE(m);
    end
end

lamda = sortE(1:m);
for i=1:m
    U(:,i) = v(:,turnV(i));
    Z(:,i) = Y*v(:,turnV(i));
end
format short;
