function out = drnd(p,n)
% out=drnd(p,n)
% copyright:rocwoods
% p is the probability distribution matrix;
% n is the number of the samples you want to generate;
% example
% x_p = [1 2 3;0.1 0.4 0.5];
% out = drnd(x_p,10)
%=================

a = cumsum(p(2,: ));    % 计算累积概率分布
b = rand(n,1);          % 产生[0,1]上均匀分布随机数
out = zeros(1,n);       % 产生0向量作为变量out的初值
% 通过循环计算指定离散分布的随机数
for k = 1:n
    c = find(a < b(k));
    if isempty(c)
        out(k) = p(1,1);
    else
        out(k) = p(1,c(end)+1);
    end
end