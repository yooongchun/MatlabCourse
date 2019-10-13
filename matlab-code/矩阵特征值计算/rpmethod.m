function [l,v,s]=rpmethod(A,x0,eps)
if nargin==2 
    eps = 1.0e-6;
end

v = x0;               %v为主特征向量
M = 5000;              %迭代步数限制
m = 0; 
l = 0;

for(k=1:M)
    y = A*v;
    m = (y'*v)/(v'*v);      %m为瑞利商
    if(rank(m)>1)
        m=(y*v')/(v*v');
    end
    v = y/m;
    
    if(abs(m - l)<eps)
        l = m;   %到所需精度，退出，l为主特征值
        s = k;
        return;
    else
        if(k==M)
            disp('迭代步数太多，收敛速度太慢！');
            l = m;
            s = M;
        else
            l = m; 
        end
    end
end


        