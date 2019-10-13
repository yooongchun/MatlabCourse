function [a,b]=LZXEC(x,y)
if(length(x) == length(y))
        n = length(x);  
else
    disp('x和y的维数不相等！');
    return;
end                  %维数检查

A = zeros(2,2);
A(2,2) = n;
B = zeros(2,1);
for i=1:n
    A(1,1) = A(1,1) + x(i)*x(i);
    A(1,2) = A(1,2) + x(i);
    B(1,1) = B(1,1) + x(i)*y(i);
    B(2,1) = B(2,1) + y(i);
end
A(2,1) = A(1,2);

s = A\B;
a = s(1);
b = s(2);
