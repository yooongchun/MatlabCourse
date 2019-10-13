%--------------------------------------------------------------------------
%                    调用textread函数读取文件中的数据
%--------------------------------------------------------------------------

% 调用textread函数读取文件examp02_01.txt中的数据，返回读取的数据矩阵x1
x1 = textread('examp02_01.txt');
% 调用textread函数读取文件examp02_02.txt中的数据，返回读取的数据矩阵x2
x2 = textread('examp02_02.txt');

% 调用textread函数读取文件examp02_03.txt中的数据，用逗号(',')作分隔符
x3 = textread('examp02_03.txt','','delimiter',',');    % 返回读取的数据矩阵x3

% 调用textread函数读取文件examp02_04.txt中的数据，指定读取格式，
% 同时用逗号、分号和星号(',;*')作分隔符
[c1,c2,c3,c4,c5]=textread('examp02_04.txt','%f %f %f %f %f','delimiter',',;*');
c5    % 查看c5的数据

% 调用textread函数读取文件examp02_05.txt中的数据，不等长部分用-1补齐
x5 = textread('examp02_05.txt','','emptyvalue',-1)    % 返回读取的数据矩阵x5

% 调用textread函数读取文件examp02_06.txt中的数据，不等长部分用-1补齐
x6 = textread('examp02_06.txt','','emptyvalue',-1)    % 返回读取的数据矩阵x6

% 调用textread函数读取文件examp02_08.txt中的数据，设置头文件行数为7
x8 = textread('examp02_08.txt','','headerlines',7)    % 返回读取的数据矩阵x8

% 调用textread函数读取文件examp02_09.txt中的数据，
% 用逗号和空格(', ')作为分隔符，把加号和i作为空格，返回读取的数据矩阵x9
x9 = textread('examp02_09.txt','','delimiter',', ','whitespace','+i')

% 调用textread函数读取文件examp02_09.txt中的数据，同时用加号、i和逗号('+i,')作为分隔符
x9 = textread('examp02_09.txt','','delimiter','+i,')

% 调用textread函数读取文件examp02_09.txt中的数据，设定读取格式
% 用逗号和空格(', ')作为分隔符，把加号和i作为空格，返回读取的数据
[c1,c2,c3,c4,c5,c6,c7,c8] = textread('examp02_09.txt',...
'%f %f %f %f %f %f %f %f','delimiter',', ','whitespace','+i');
x9 = [c1,c2,c3,c4,c5,c6,c7,c8]    % 查看读取的数据

% 调用textread函数读取文件examp02_10.txt中的数据，设定读取格式
% 同时用减号、逗号和冒号('-,:')作为分隔符，返回读取的数据
 [c1,c2,c3,c4,c5,c6,c7] = textread('examp02_10.txt',...
'%4d %d %2d %d %d %6.3f %s','delimiter','-,:');
[c1,c2,c3,c4,c5,c6]    % 查看读取的数据

% 设定读取格式
format = '%s %s %s %d %s %d %s %d %s';
% 调用textread函数读取文件examp02_11.txt中的数据，
% 用冒号和空格': '作为分隔符，返回读取的数据
[c1,c2,c3,c4,c5,c6,c7,c8,c9] = textread('examp02_11.txt',format,...
'delimiter',': ');
[c4 c6 c8]    % 查看读取的数据