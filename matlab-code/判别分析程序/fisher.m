function [outclass,TabCan,TabL,TabCon,TabM,TabG,trainscore] = fisher(sampledata,training,group,contri)
%FISHER 判别分析.
%   class = fisher(sampledata,training,group) 根据训练样本training构造判别式，
%   利用所有判别式对待判样品sampledata进行判别. sampledata和training是具有相同
%   列数的矩阵，它们的每一行对应一个观测，每一列对应一个变量. group是training对
%   应的分组变量，它的每一个元素定义了training中相应观测所属的类. group可以是一
%   个分类变量，数值向量，字符串数组或字符串元胞数组. training和group必须具有相
%   同的行数. fisher函数把group中的NaN或空字符串作为缺失数据，从而忽略training
%   中相应的观测. class中的每个元素指定了sampledata中的相应观测所判归的类,它和
%   group具有相同的数据类型. 
%
%   class = fisher(sampledata,training,group,contri) 根据累积贡献率不低于
%   contri，确定需要使用的判别式个数，默认情况下，使用所有判别式进行判别. contri
%   是一个在(0, 1]区间内取值的标量，用来指定累积贡献率的下限. 
%
%   [class, TabCan] = fisher(...)以表格形式返回所用判别式的系数向量，若contri
%   取值为1，则返回所有判别式的系数向量. TabCan是一个元胞数组，形如
%       'Variable'    'can1'       'can2'   
%       'x1'          [-0.2087]    [ 0.0065]
%       'x2'          [-0.3862]    [ 0.5866]
%       'x3'          [ 0.5540]    [-0.2526]
%       'x4'          [ 0.7074]    [ 0.7695]

%   [class, TabCan, TabL] = fisher(...)以表格形式返回所有特征值，贡献率，累积
%   贡献率等. TabL是一个元胞数组，形如
%       'Eigenvalue'    'Difference'    'Proportion'    'Cumulative'
%       [   32.1919]    [   31.9065]    [    0.9912]    [    0.9912]
%       [    0.2854]              []    [    0.0088]    [         1]
%
%   [class, TabCan, TabL, TabCon] = fisher(...)以表格形式返回混淆矩阵（包含总
%   的分类信息的矩阵）. TabCon是一个元胞数组，形如
%       'From/To'       'setosa'    'versicolor'    'virginica'
%       'setosa'        [    50]    [         0]    [        0]
%       'versicolor'    [     0]    [        48]    [        2]
%       'virginica'     [     0]    [         1]    [       49]
%
%   [class, TabCan, TabL, TabCon, TabM] = fisher(...)以表格形式返回误判矩阵. 
%   TabM是一个元胞数组，形如
%       'Obj'    'From'          'To'        
%       [ 71]    'versicolor'    'virginica' 
%       [ 84]    'versicolor'    'virginica' 
%       [134]    'virginica'     'versicolor'
%
%   [class, TabCan, TabL, TabCon, TabM, TabG] = fisher(...)将所用判别式作用
%   在各组的组均值上，得到组均值投影矩阵，以表格形式返回这个矩阵. TabG是一个元胞
%   数组，形如
%       'Group'         'can1'       'can2'  
%       'setosa'        [-1.3849]    [1.8636]
%       'versicolor'    [ 0.9892]    [1.6081]
%       'virginica'     [ 1.9852]    [1.9443]

%   [class, TabCan, TabL, TabCon, TabM, TabG, trainscore] = fisher(...)返回
%   训练样品所对应的判别式得分trainscore. trainscore的第一列为各训练样品原本所
%   属类的类序号，第i+1列为第i个判别式得分.
%
%   Copyright 2009 xiezhh.
%   $Revision: 1.0.0.0 $  $Date: 2009/10/03 10:40:34 $

if nargin < 3
    error('错误：输入参数太少，至少需要3个输入.');
end

% 根据分组变量生成索引向量gindex，组名元胞向量groups，组水平向量glevels
[gindex,groups,glevels] = grp2idx(group);
% 忽略缺失数据
nans = find(isnan(gindex));
if ~isempty(nans)
    training(nans,:) = [];
    gindex(nans) = [];
end
ngroups = length(groups);
gsize = hist(gindex,1:ngroups);
nonemptygroups = find(gsize>0);
nusedgroups = length(nonemptygroups);

% 判断是否有空的组
if ngroups > nusedgroups
    warning('警告: 有空的组.');
end

[n,d] = size(training);
if size(gindex,1) ~= n
    error('错误: 输入参数大小不匹配，GROUP与TRAINING必须具有相同的行数.');
elseif isempty(sampledata)
    sampledata = zeros(0,d,class(sampledata));
elseif size(sampledata,2) ~= d
    error('错误: 输入参数大小不匹配，SAMPLEDATA与TRAINING必须具有相同的列数.');
end

% 设置contri的默认值为1，并限定contri在(0, 1]内取值
if nargin < 4 || isempty(contri)
    contri = 1;
end
if ~isscalar(contri) || contri > 1 || contri <= 0
    error('错误: contri 必须是一个在(0, 1]内取值的标量.');
end

if any(gsize == 1)
    error('错误: TRAINING中的每个组至少应有两个观测.');
end

% 计算各组的组均值
gmeans = NaN(ngroups, d);
for k = nonemptygroups
    gmeans(k,:) = mean(training(gindex==k,:),1);
end
% 计算总均值
totalmean = mean(training,1);

% 计算组内离差平方和矩阵E和组间离差平方和矩阵B
E = zeros(d);
B = E;
for k = nonemptygroups
    % 分别估计各组的组内离差平方和矩阵. 
    [Q,Rk] = qr(bsxfun(@minus,training(gindex==k,:),gmeans(k,:)), 0);
    % 各组的组内离差平方和矩阵：AkHat = Rk'*Rk
    % 判断各组的组内离差平方和矩阵的正定性
    s = svd(Rk);
    if any(s <= max(gsize(k),d) * eps(max(s)))
        error('错误: TRAINING中各组的组内离差平方和矩阵必须是正定矩阵.');
    end
    E = E + Rk'*Rk;    % 计算总的组内离差平方和矩阵E
    % 计算组间离差平方和矩阵B
    B = B + (gmeans(k,:) - totalmean)'*(gmeans(k,:) - totalmean)*gsize(k);
end

%  求inv(E)*B的正特征值与相应的特征向量
EB = E\B;
[V, D] = eig(EB);
D = diag(D);
[D, idD] = sort(D,'descend');  %将特征值按降序排列
V = V(:,idD);
NumPosi = min(ngroups-1, d);  %确定正特征值个数
D = D(1:NumPosi, :);
CumCont = cumsum(D/sum(D));  %计算累积贡献率

% 以表格形式返回所有特征值，贡献率，累积贡献率等. TabL是一个元胞数组
head = {'Eigenvalue', 'Difference', 'Proportion', 'Cumulative'};
TabL = cell(NumPosi+1, 4);
TabL(1,:) = head;
TabL(2:end,1) = num2cell(D);
if NumPosi == 1
    TabL(2:end-1,2) = {0};
else
    TabL(2:end-1,2) = num2cell(-diff(D));
end
TabL(2:end,3) = num2cell(D/sum(D));
TabL(2:end,4) = num2cell(CumCont);

% 根据累积贡献率的下限contri确定需要使用的判别式个数CumContGeCon
CumContGeCon = find(CumCont >= contri);
CumContGeCon = CumContGeCon(1);
V = V(:, 1:CumContGeCon);  %需要使用的判别式系数矩阵

% 以表格形式返回所用判别式的系数向量，若contri取值为1，
% 则返回所有判别式的系数向量. TabCan是一个元胞数组
TabCan = cell(d+1, CumContGeCon+1);
TabCan(1, 1) = {'Variable'};
TabCan(2:end, 1) = strcat('x',cellstr(num2str((1:d)')));
TabCan(1, 2:end) = strcat('can',cellstr(num2str((1:CumContGeCon)')));
TabCan(2:end, 2:end) = num2cell(V);

% 将训练样品与待判样品放在一起进行判别
m = size(sampledata,1);
gv = gmeans*V;
stv = [sampledata; training]*V;
nstv = size(stv, 1);
message = '';
outclass = NaN(nstv, 1);
for i = 1:nstv
    obji = bsxfun(@minus,stv(i,:),gv);
    obji = sum(obji.^2, 2);
    idclass = find(obji == min(obji));
    if length(idclass) > 1
        idclass = idclass(1);
        message = '警告: 出现了一个或多个结';
    end
    outclass(i) = idclass;
end
warning(message);
trclass = outclass(m+(1:n));  %训练样品的判别结果（由类序号构成的向量）
outclass = outclass(1:m);  %待判样品的判别结果（由类序号构成的向量）
outclass = glevels(outclass,:);  %将待判样品的判别结果进行一个类型转换

trg1 = groups(gindex);  %训练样品的初始类名称
trg2 = groups(trclass);  %训练样品经判别后的类名称
% 以表格形式返回混淆矩阵（包含总的分类信息的矩阵）. TabCon是一个元胞数组
[CLMat, order] = confusionmat(trg1,trg2);
TabCon = [[{'From/To'},order'];order, num2cell(CLMat)];

% 以表格形式返回误判矩阵. TabM是一个元胞数组
miss = find(gindex ~= trclass);  %训练样品中误判样品的编号
head1 = {'Obj', 'From', 'To'};
TabM = [head1; num2cell(miss), trg1(miss), trg2(miss)];

% 将所用判别式作用在各组的组均值上，得到组均值投影矩阵，以表格形式返回这个矩阵. 
% TabG是一个元胞数组
TabG = cell(ngroups+1,CumContGeCon+1);
TabG(:,1) = [{'Group'};groups];
TabG(1,2:end) = strcat('can',cellstr(num2str((1:CumContGeCon)')));
TabG(2:end,2:end) = num2cell(gv);

% 计算训练样品所对应的判别式得分
trainscore = training*V;
trainscore = [gindex, trainscore];