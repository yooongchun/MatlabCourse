%--------------------------------------------------------------------------
%                   调用anovan函数作双因素一元方差分析
%--------------------------------------------------------------------------

% 定义一个矩阵，输入原始数据
yield = [38	29	36	40
         45	42	37	43
         58	46	52	51
         67	70	65	71
         62	64	61	70
         58	63	71	69];
yield = yield';  % 矩阵转置
% 将数据矩阵yield按列拉长成24行1列的向量
yield = yield(:);

% 定义因素A（氮）的水平列表向量
A = strcat({'N'},num2str([ones(8,1);2*ones(8,1);3*ones(8,1)]));
% 定义因素B（磷）的水平列表向量
B = strcat({'P'},num2str([ones(4,1);2*ones(4,1)]));
B = [B;B;B];
% 将因素A，B的水平列表向量与yield向量放在一起构成一个元胞数组，以元胞数组形式显示出来
[A, B, num2cell(yield)]

varnames = {'A','B'};  % 指定因素名称，A表示氮肥施用量，B表示磷肥施用量

% 调用anovan函数作双因素一元方差分析，返回主效应A，B和交互效应AB所对应的p值向量p，
% 还返回方差分析表table，结构体变量stats，标识模型效应项的矩阵term
[p,table,stats,term] = anovan(yield,{A,B},'model','full','varnames',varnames)

% 调用multcompare对各处理进行多重比较
[c,m,h,gnames] = multcompare(stats,'dimension',[1 2]);
c  % 查看多重比较结果矩阵c

[gnames, num2cell(m)]  %查看各处理的均值