function A=multifit(X,Y,m)
%A--输出的拟合多项式的系数
N=length(X);
M=length(Y);
if(N ~= M)
    disp('数据点坐标不匹配！');
    return;
end

c(1:(2*m+1))=0;
b(1:(m+1))=0;

for j=1:(2*m+1)          %求出c和b
    for k=1:N
        c(j)=c(j)+X(k)^(j-1);
        if(j<(m+2))
            b(j)=b(j)+Y(k)*X(k)^(j-1);
        end
    end
end

C(1,:)=c(1:(m+1));
for s=2:(m+1)
    C(s,:)=c(s:(m+s));
end

A=b'\C;                 %直接求解法求出拟合系数

