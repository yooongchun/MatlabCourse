%--------------------------------------------------------------------------
%                    调用random函数生成指定分布随机数
%--------------------------------------------------------------------------

xvalue = [-2 -1 0 1 2];    % 定义向量xvalue
xp = [0.05 0.2 0.5 0.2 0.05];    % 定义向量xp
% 调用randsample函数生成100个服从指定离散分布的随机数
x = randsample(xvalue, 100, true, xp);
reshape(x,[10 10])    % 把向量x转换成一个10行10列的矩阵，并显示出来

% 调用第1章例1.37中的HistRate函数统计向量x中各数字出现的频数、频率和累积频率
HistRate(x)

% 调用randsample函数生成10000个服从指定离散分布的随机数
x = randsample(xvalue, 10000, true, xp);
% 调用HistRate函数统计向量x中各数字出现的频数、频率和累积频率
HistRate(x)

% 调用randsample函数生成100000个服从指定离散分布的随机数
x = randsample(xvalue, 100000, true, xp);
% 调用HistRate函数统计向量x中各数字出现的频数、频率和累积频率
HistRate(x)



xvalue = [-2 -1 0 1 2];    % 定义向量xvalue
xp = [0.05 0.2 0.5 0.2 0.05];    % 定义向量xp
rand('twister', 1)    % 设置随机数生成器的算法为Mersenne Twister算法，初始种子为1

% 调用randsample函数生成10000个服从指定离散分布的随机数
x1 = randsample(xvalue, 10000, true, xp);
% 调用HistRate函数统计向量x1中各数字出现的频数、频率和累积频率
HistRate(x1)

rand('twister', 1)    % 设置随机数生成器的算法为Mersenne Twister算法，初始种子为1
% 调用drnd函数生成10000个服从指定离散分布的随机数
x2 = drnd([xvalue; xp], 10000);
% 调用HistRate函数统计向量x2中各数字出现的频数、频率和累积频率
HistRate(x2)

isequal(x1,x2)    % 比较向量x1和x2是否完全相同