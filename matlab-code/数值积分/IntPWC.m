function q = IntPWC(X,Y,n)
format long;
h = zeros(n-1,1);
lamda = zeros(n,1);
L = zeros(n-2,1);
R = zeros(n-2,1);
Dlta = zeros(n-2,1);
h(1) = X(2)-X(1);
for j=1:n-2          %计算每个子区间的积分参数
    h(j+1) = X(j+2)-X(j+1);
    lamda(j) = h(j)/h(j+1);
    Dlta(j) = h(j+1)/h(j);
    L(j) = (Dlta(j)*Dlta(j))*Y(j)/(1+Dlta(j))-Dlta(j)*Y(j+1)+...
           +Dlta(j)*Y(j+2)/(1+Dlta(j));
    R(j) = (lamda(j)*lamda(j))*Y(j+2)/(1+lamda(j))-lamda(j)*Y(j+1)+...
           +lamda(j)*Y(j)/(1+lamda(j));
end
q = h(1)*(3*Y(1)+3*Y(2)-R(1))/6+h(n-1)*(3*Y(n-1)+3*Y(n)-L(n-2))/6;
for k=2:n-2
    q = q + h(k)*(3*Y(k)+3*Y(k+1)-0.5*R(k)-0.5*L(k-1))/6;
end
format short;
