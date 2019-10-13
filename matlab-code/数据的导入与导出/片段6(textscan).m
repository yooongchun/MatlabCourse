%--------------------------------------------------------------------------
%                    调用textscan函数读取文件中的数据
%--------------------------------------------------------------------------

fid = fopen('examp02_13.txt');    % 打开文件examp02_13.txt，返回文件标识符fid
C = textscan(fid, '%s %s %f32 %d8 %u %f %f %s')    % 以指定格式读取文件中数据
fclose(fid);    % 关闭文件

fid = fopen('examp02_08.txt','r');    % 以只读方式打开文件examp02_08.txt
fgets(fid);    % 读取文件的第1行
fgets(fid);    % 读取文件的第2行
% 调用textscan函数以指定格式从文件examp02_08.txt的第3行开始读取数据，
% 并将读取的具有相同数据类型的连续元胞连接成一个元胞数组A
A = textscan(fid, '%f %f %f %f %f %f', 'CollectOutput', 1)
fgets(fid);    % 读取文件的第6行
fgets(fid);    % 读取文件的第7行
% 调用textscan函数以指定格式从文件examp02_08.txt的第8行开始读取数据，
% 并将读取的具有相同数据类型的连续元胞连接成一个元胞数组B
B = textscan(fid, '%f %f %f', 'CollectOutput', 1)
fclose(fid);    % 关闭文件

fid = fopen('examp02_09.txt','r');    % 以只读方式打开文件examp02_09.txt
% 调用textscan函数以指定格式从文件examp02_09.txt中读取数据，用空格(' ')作分隔符
% 并将读取的具有相同数据类型的连续元胞连接成一个元胞数组A
A = textscan(fid, '%f %*s %f %*s %f %*s %f %*s','delimiter',...
' ', 'CollectOutput', 1)
A{:}    % 查看A中的数据
fclose(fid);    % 关闭文件

fid = fopen('examp02_10.txt','r');    % 以只读方式打开文件examp02_10.txt
% 调用textscan函数以指定格式从文件examp02_10.txt中读取数据，用'-,:'作分隔符
% 并将读取的具有相同数据类型的连续元胞连接成一个元胞数组A
A = textscan(fid, '%d %d %d %d %d %f %*s','delimiter','-,:','CollectOutput',1)
A{1,1}    % 查看A的第1行，第1列的元胞中的数据
fclose(fid);    % 关闭文件

fid = fopen('examp02_11.txt','r');    % 以只读方式打开文件examp02_11.txt
% 调用textscan函数以指定格式从文件examp02_11.txt中读取数据，用空格(' ')作分隔符
% 并将读取的具有相同数据类型的连续元胞连接成一个元胞数组A
A = textscan(fid, '%*s %s %*s %d %*s %d %*s %d %*s',...
'delimiter', ' ', 'CollectOutput',1)
A{1,1}    % 查看A的第1行，第1列的元胞中的数据
A{1,2}    % 查看A的第1行，第2列的元胞中的数据
fclose(fid);    % 关闭文件