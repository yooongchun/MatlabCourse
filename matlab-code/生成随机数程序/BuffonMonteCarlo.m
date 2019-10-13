function  [p0,pm,pival] = BuffonMonteCarlo(d,h,N)
% 蒲丰投针问题
%   pivalue = BuffonMonteCarlo(d,h,N)，求蒲丰投针问题中针与任一平行线相交的理论
%   概率p0，基于蒙特卡洛方法的模拟概率pm，圆周率pi的模拟值pival. 输入参数d为相邻
%   两条平行线的间距，h为针的长度，N为模拟投针的次数.

% 判断针的长度h与相邻平行线的间距d是否满足指定条件
if h >= d
    error('针的长度应小于相邻平行线的间距')
end
p0 = 2*h/(d*pi);  % 计算针与任一平行线相交的理论概率
x = 0;y = 0;  % 赋变量初值
m = length(N);  % 求变量N的长度
pm = zeros(1,m);  % 赋变量初值
pival = pm;  % 赋变量初值
% 通过循环求基于蒙特卡洛方法的模拟概率pm和圆周率pival
for i = 1:m
    x = pi*rand(N(i),1);  % 产生[0,pi]上均匀分布随机数
    y = d*rand(N(i),1)/2;  % 产生[0,d/2]上均匀分布随机数
    yb = h*sin(x)/2;
    pm(i) = sum(y <= yb)/N(i);  % 求模拟概率
    pival(i) = 2*h*N(i)/(d*sum(y <= yb));  % 求圆周率的模拟值
end