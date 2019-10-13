function [x,N]= BJ(A,b,x0,d,eps,M)
if nargin==4
    eps= 1.0e-6;
    M  = 10000;
elseif nargin<4
    error
    return
elseif nargin ==5
    M  = 10000;             %参数的默认值
end  

NS = size(A);
n = NS(1,1);                
if(sum(d) ~= n)
    disp('分块错误！');
    return;
end
bnum = length(d);
bs = ones(bnum,1);
for i=1:(bnum-1)
    bs(i+1,1)=sum(d(1:i))+1;  
    %获得对角线上每个分块矩阵元素索引的起始值
end

DB = zeros(n,n);                
for i=1:bnum
    endb = bs(i,1)+d(i,1)-1;
    DB(bs(i,1):endb,bs(i,1):endb)=A(bs(i,1):endb,bs(i,1):endb);
    %求A的对角分块矩阵
end
for i=1:bnum
    endb = bs(i,1)+d(i,1)-1;
    invDB(bs(i,1):endb,bs(i,1):endb)=inv(DB(bs(i,1):endb,bs(i,1):endb));
    %求A的对角分块矩阵的逆矩阵
end

N = 0;
tol = 1;
while tol>=eps 
    x = invDB*(DB-A)*x0+invDB*b;    %由于LB+DB=DB-A
    N = N+1;                               %迭代步数
    tol = norm(x-x0);                   %前后两步迭代结果的误差
    x0 = x;
    if(N>=M)
        disp('Warning: 迭代次数太多，可能不收敛！');
        return;
    end
end
