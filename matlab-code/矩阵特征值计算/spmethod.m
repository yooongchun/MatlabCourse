function T=spmethod(A,eps)
if nargin==1 
    eps = 1.0e-6;
end

N = size(A);
n = N(1,1);
T = zeros(n,n);
B = A;
B1= B;

for(i=1:n) 
    s  = size(B);
    r  = s(1,1);                             %r为B的阶
    [T(i,i),u] = pmethod(B,ones(r,1),eps);   %用幂法求解主特征值和主特征向量 
    u = u/u(1,1);                            %将主特征向量规一化
    B1 = B - u*B(1,:);                       
    s1  = size(B1);
    r1  = s(1,1);
    B  = B1(2:r1,2:r1);                      %B为收缩后的矩阵
end

