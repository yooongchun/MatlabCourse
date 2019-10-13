function a=ZJZXEC(x,y,m)
if(length(x) == length(y))
    n = length(x);  
else
    disp('x和y的维数不相等！');
    return;
end                  %维数检查

syms v;
d = zeros(1,m+1);
q = zeros(1,m+1);
alpha = zeros(1,m+1);
for k=0:m
   px(k+1)=power(v,k);
end                      %x的幂多项式
B2 = [1];
d(1) = n;
for l=1:n
    q(1) = q(1) + y(l);
    alpha(1) = alpha(1) + x(l);
end
q(1) = q(1)/d(1);
alpha(1) = alpha(1)/d(1);
a(1) = q(1);
B1 = [-alpha(1) 1];
for l=1:n
    d(2) = d(2) + (x(l)-alpha(1))^2;
    q(2) = q(2) + y(l)*(x(l)-alpha(1));
    alpha(2) = alpha(2) + x(l)*(x(l)-alpha(1))^2;
end
q(2) = q(2)/d(2);
alpha(2) = alpha(2)/d(2);
a(1) = a(1)+q(2)*(-alpha(1));
a(2) = q(2);
beta = d(2)/d(1);

for i=3:(m+1)
    B = zeros(1,i);
    B(i) = B1(i-1);
    B(i-1) = -alpha(i-1)*B1(i-1)+B1(i-2);
    for j=2:i-2
       B(j) = -alpha(i-1)*B1(j)+B1(j-1)-beta*B2(j);
    end
    B(1) = -alpha(i-1)*B1(1)-beta*B2(1);
    BF = B*transpose(px(1:i));
    for l=1:n
        Qx = subs(BF,'v',x(l));
        d(i) = d(i) + (Qx)^2;
        q(i) = q(i) + y(l)*Qx;
        alpha(i) = alpha(i) + x(l)*(Qx)^2;
    end
    alpha(i) = alpha(i)/d(i);
    q(i) = q(i)/d(i);
    beta = d(i)/d(i-1);
    for k=1:i-1
        a(k) = a(k)+q(i)*B(k);
    end
    a(i) = q(i)*B(i);
    B2 = B1;
    B1 = B;
end
