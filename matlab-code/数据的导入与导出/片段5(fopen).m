%--------------------------------------------------------------------------
%                         调用fopen函数打开文件
%--------------------------------------------------------------------------

% 调用fopen函数打开一个不存在的文件xiezhh.txt
[fid, message] = fopen('xiezhh.txt')    % 返回文件标识符fid和相关信息message

fid = fopen('xiezhh.txt')    % 调用fopen函数打开一个不存在的文件xiezhh.txt
[filename, permission] = fopen(fid)    % 得到被打开文件的信息

% 调用fopen函数以只读方式打开文件examp02_01.txt 
fid = fopen('examp02_01.txt','rt');    % 返回文件标识符fid
tline = fgets(fid, 32)    % 读取文件examp02_01.txt的一行上的32个字符
fclose(fid);    % 关闭文件
