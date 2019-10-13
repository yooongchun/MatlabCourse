%--------------------------------------------------------------------------
%                调用importdata函数读取文件中的数据
%--------------------------------------------------------------------------

% 调用importdata函数读取文件examp02_04.txt中的数据
importdata('examp02_04.txt')

% 调用importdata函数读取文件examp02_07.txt中的数据，返回结构体变量x
x = importdata('examp02_07.txt')
x.data    % 查看读取的数值型数据
x.textdata    % 查看读取的文本数据

% 调用importdata函数读取文件examp02_03.txt中的数据，用';'作分隔符，返回字符串元胞数组x
x = importdata('examp02_03.txt',';')
x{1}    % 查看x的第1个元胞中的字符

% 调用importdata函数读取文件examp02_08.txt中的数据，用空格作分隔符，设置头文件行数为2
x = importdata('examp02_08.txt',' ',2)    % 返回结构体变量x

% 调用importdata函数读取文件examp02_07.txt中的数据
% 返回结构体变量x，分隔符s，头文件行数h
[x, s, h] = importdata('examp02_07.txt')

% 调用importdata函数读取文件examp02_10.txt中的数据
FileContent = importdata('examp02_10.txt')    % 返回字符串元胞数组FileContent
FileContent = char(FileContent)    % 将字符串元胞数组转为字符矩阵
t = str2num(FileContent(:, 8:9))    % 提取字符矩阵的第8至9列，并转为数字