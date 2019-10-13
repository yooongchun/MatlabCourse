function [l,v]=dimethod(A,x0,u,eps)
if nargin==3 
    eps = 1.0e-6;
end

N = size(A);
n = N(1,1);            %n为A的阶
v = x0;              
M = 5000;              %迭代步数限制
m = 0;      
l = 0;
for(k=1:M)
    y = (A-u*eye(n,n))\v;
    m = max(y);      %m为按模最大的分量
    v = y/m;
    
    if(abs(m - l)<eps)
        l = 1/m + u;       %到所需精度，退出
        return;
    else
        if(k==M)
            disp('迭代步数太多，收敛速度太慢！');
            l = 1/m + u;
        else
            l = m;
        end
    end
end


        