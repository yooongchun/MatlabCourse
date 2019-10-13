%--------------------------------------------------------------------------
%                   调用dlmread函数读取文件中的数据
%--------------------------------------------------------------------------

% 调用dlmread函数读取文件examp02_03.txt中的数据
x = dlmread('examp02_03.txt')    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_03.txt中的数据，用逗号(',')作分隔符，设定读取的初始位置
x = dlmread('examp02_03.txt', ',', 2, 3)    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_03.txt中的数据，用逗号(',')作分隔符，设定读取的范围
x = dlmread('examp02_03.txt', ',', [1, 2, 2, 5])    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_04.txt中的数据，出现错误
x = dlmread('examp02_04.txt')

% 调用dlmread函数读取文件examp02_05.txt中的数据
x = dlmread('examp02_05.txt')    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_06.txt中的数据
x = dlmread('examp02_06.txt')    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_07.txt中的数据，出现错误
x = dlmread('examp02_07.txt')

% 调用dlmread函数读取文件examp02_07.txt中的数据，用逗号(',')作分隔符，设定读取的初始位置
x = dlmread('examp02_07.txt', ',', 2,0)    % 返回读取的数据矩阵x

% 调用dlmread函数读取文件examp02_08.txt中的数据，用空格(' ')作分隔符，设定读取的范围
x = dlmread('examp02_08.txt', ' ', [7,0,8,8])
x = x(:, 1:4:end)    % 提取矩阵x的第1，5，9列

% 调用dlmread函数读取文件examp02_09.txt中的数据
x = dlmread('examp02_09.txt')    % 返回读取的复数矩阵x