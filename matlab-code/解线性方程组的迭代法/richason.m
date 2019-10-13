function [x,n]=richason(A,b,x0,eps,M)
if(nargin == 3)
    eps = 1.0e-6;
      M = 200;
elseif(nargin == 4)
      M = 200;
end

I =eye(size(A));
x1=x0;
x=(I-A)*x0+b;
n=1;

while(norm(x-x1)>eps)
    x1=x;
    x=(I-A)*x1+b;
    n = n + 1;
    if(n>=M)
        disp('Warning: 迭代次数太多，现在退出！');
        return;
    end
end