function [l,v]=ipmethod(A,x0,eps)
if nargin==2 
    eps = 1.0e-6;
end

v = x0;               
M = 5000;              %迭代步数限制
m = 0; 
l = 0;

for(k=1:M)
    y = A\v;
    m = max(y);      %m为按模最大的分量
    v = y/m;
    
    if(abs(m - l)<eps)
        l = 1/m;   %到所需精度，退出，l为按模的最小特征值
        return;
    else
        if(k==M)
            disp('迭代步数太多，收敛速度太慢！');
            l = 1/m;
        else
            l = m; 
        end
    end
end


        