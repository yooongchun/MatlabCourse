function [S0,Sm] = quad1mont(n)
%   [S0,Sm] = quad1mont(n),求曲线 y = sqrt(x)与直线 y = x 所围成的阴影区域的
%   面积的理论值S0与蒙特卡洛模拟值Sm. 输入参数n是随机投点的个数，可以是正整数标
%   量或向量.

%S0 = int('sqrt(x)-x',0,1);  % 面积的理论值（解析解）
S0 = quad(@(x)sqrt(x)-x,0,1);  % 面积的理论值（数值解）
% 计算阴影区域的面积的蒙特卡洛模拟值
for i = 1:length(n)
    x = rand(n(i),1);  % 点的横坐标
    y = rand(n(i),1);  % 点的纵坐标
    m = sum(sqrt(x) >= y & y >= x); % 落到阴影区域内点的频数
    Sm(i) = m/n(i);  % 落到阴影区域内点的频率，即概率的模拟值
end