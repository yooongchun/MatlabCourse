function [x,n]=grs(A,b,x0,W,eps,M)
if(nargin == 4)
    eps = 1.0e-6;                            %eps表示迭代精度
      M = 10000;                              %M表示迭代步数的限制值
elseif(nargin == 5)
      M = 10000;
end
I =eye(size(A));
n=0;
x=x0;
tol=1;                                         %前后两次迭代结果误差
%迭代过程
while (tol>eps)
    x = (I-W*A)*x0+W*b;                     %迭代公式
    n = n + 1;                                  %n为最终求出解时的迭代步数
    tol = norm(x-x0);
    x0 = x;
    if(n>=M)
        disp('Warning:迭代次数太多，可能不收敛！');
        return;
    end
end
