function [p0,p] = probmont(n,m,N)
%   [p0,p] = probmont(n,m,N)，有n个球，从中有放回地随机抽取 m 次，求每个球都能
%   被取到的理论概论p0和蒙特卡洛模拟概率p.输入参数N为随机模拟次数.

% 当抽球次数m小于球的总数n时，理论概率和模拟概率均为0
if n > m
    p0 = 0;  % 理论概率
    p = 0;  % 模拟概率
    return;
end
i = 0:n;  % 定义一个向量
% 计算理论概率
p0 = sum((-1).^i*factorial(n)./(factorial(i).*factorial(n-i)).*(1-i/n).^(m));

num = 0;
x = 0;
% 计算模拟概率
for i = 1:N
    x = randsample(n,m,'true');  % 有放回随机抽样
    % 如果n个数都被抽到，将计数器的值增加1
    if numel(unique(x)) == n
        num = num + 1;
    end
end
p = num/N;  % 模拟概率