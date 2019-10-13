function [x,IA]=InvAddSide(A,b)
IA = Inv(A);
x = IA*b;

%求逆矩阵的递归函数
function invA=Inv(A)
N = size(A);
n = N(1);
if(n == 1)
    invA = 1/A(n,n);                   %递归的终止条件
else
    u = A(1:(n-1),n);
    v = A(n,1:(n-1));
    iA = Inv(A(1:(n-1),1:(n-1)));   %递归公式
    An = A(n,n) - v*iA*u;
    r = -iA*u/An;
    p = iA + iA*u*v*iA/An;
    q = -v*iA/An;
    invA = [p r;q 1/An];               %逆矩阵
end
