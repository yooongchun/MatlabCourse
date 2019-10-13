%--------------------------------------------------------------------------
%                    调用load函数读取文件中的数据
%--------------------------------------------------------------------------

load examp02_01.txt    % 用load函数载入文件examp02_01.txt中的数据
load  -ascii  examp02_01.txt    % 用-ascii选项强制以文本文件方式读取数据
x1 = load('examp02_02.txt')    % 用load函数载入文件examp02_02.txt中的数据

x1 = load('examp02_02.txt', '-ascii');    % 用-ascii选项强制以文本文件方式读取数据
% 调用dlmread函数读取文件examp02_01.txt中的数据
x2 = dlmread('examp02_01.txt');
% 调用textread函数读取文件examp02_01.txt中的数据
x3 = textread('examp02_01.txt');
load examp02_03.txt    % 用load函数载入文件examp02_03.txt中的数据
load examp02_04.txt    % 用load函数载入文件examp02_04.txt中的数据

% 用load函数载入文件examp02_05.txt中的数据，出现错误
load examp02_05.txt

% 用load函数载入文件examp02_07.txt中的数据，出现错误
load examp02_07.txt

% 用load函数载入文件examp02_10.txt中的数据，出现错误
load examp02_10.txt

% 用load函数载入文件examp02_11.txt中的数据，出现错误
load examp02_11.txt

x = load('examp02_12.txt')    % 用load函数载入文件examp02_12.txt中的数据