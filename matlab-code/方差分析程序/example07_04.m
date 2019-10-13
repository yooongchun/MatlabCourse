%--------------------------------------------------------------------------
%                   调用anovan函数作多因素一元方差分析
%--------------------------------------------------------------------------

% 从文件examp07_04.xls中读取数据
ydata = xlsread('examp07_04.xls');
y = ydata(:,7);  % 提取ydata的第7列数据，即产蛋量y
A = ydata(:,2);  % 提取ydata的第2列数据，即因素A的水平列表
B = ydata(:,3);  % 提取ydata的第3列数据，即因素B的水平列表
C = ydata(:,4);  % 提取ydata的第4列数据，即因素C的水平列表
D = ydata(:,6);  % 提取ydata的第6列数据，即因素D的水平列表
E = ydata(:,5);  % 提取ydata的第5列数据，即因素E的水平列表
varnames = {'A','B','C','D','E'};  % 定义因素名称
% 定义模型的效应项矩阵，考虑主效应：A,B,C,D,E，交互效应：AB,AC,AE
model = [eye(5);1 1 0 0 0;1 0 1 0 0;1 0 0 0 1]

% 调用anovan函数作多因素一元方差分析
[p,table] = anovan(y,{A,B,C,D,E},'model',model,'varnames',varnames)


%********************************重新作方差分析*****************************
% 定义模型的效应项矩阵，考虑主效应：A,B,C,D,E，交互效应：AC
model = [eye(5);1 0 1 0 0]

% 调用anovan函数作多因素一元方差分析
[p,table,stats] = anovan(y,{A,B,C,D,E},'model',model,'varnames',varnames);
p  % 查看p的值
table  % 查看table的值


%********************************多重比较**********************************
% 调用multcompare对5个因素的各水平进行多重比较
[c,m,h,gnames] = multcompare(stats,'dimension',[1 2 3 4 5]);
% 将各处理的均值从小到大进行排序
[mean,id] = sort(m(:,1));
% 将各处理的名称按均值从小到大进行排序
gnames = gnames(id);
% 显示排序后的后20个处理的名称及相应的均值
[{'处理','均值'};gnames(end-19:end),num2cell(mean(end-19:end))]