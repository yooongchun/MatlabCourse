function stats = reglm(y,X,model,varnames)
% 多重线性回归分析或广义线性回归分析
%
%   reglm(y,X)，产生线性回归分析的方差分析表和参数估计结果，并以表格形式显示在屏幕上. 参
%   数X是自变量观测值矩阵，它是n行p列的矩阵. y是因变量观测值向量，它是n行1列的列向量.
%
%   stats = reglm(y,X)，还返回一个包括了回归分析的所有诊断统计量的结构体变量stats.
%
%   stats = reglm(y,X,model)，用可选的model参数来控制回归模型的类型. model是一个字符串，
%   其可用的字符串如下
%       'linear'          带有常数项的线性模型（默认情况）
%       'interaction'     带有常数项、线性项和交叉项的模型
%       'quadratic'       带有常数项、线性项、交叉项和平方项的模型
%       'purequadratic'   带有常数项、线性项和平方项的模型
%
%   stats = reglm(y,X,model,varnames)，用可选的varnames参数指定变量标签. varnames
%   可以是字符矩阵或字符串元胞数组，它的每行的字符或每个元胞的字符串是一个变量的标签，它的行
%   数或元胞数应与X的列数相同. 默认情况下，用X1,X2,…作为变量标签.
%
%   例:
%   x = [215 250 180 250 180 215 180 215 250 215 215
%       136.5 136.5 136.5 138.5 139.5 138.5 140.5 140.5 140.5 138.5 138.5]';
%   y = [6.2 7.5 4.8 5.1 4.6 4.6 2.8 3.1 4.3 4.9 4.1]';
%   reglm(y,x,'quadratic')
%
%   ------------------------------------方差分析表------------------------------------
%   方差来源    自由度            平方和             均方             F值          p值
%   回归       5.0000          15.0277           3.0055          7.6122      0.0219
%   残差       5.0000           1.9742           0.3948
%   总计      10.0000          17.0018
%
%         均方根误差(Root MSE)     0.6284             判定系数(R-Square)    0.8839
%   因变量均值(Dependent Mean)     4.7273        调整的判定系数(Adj R-Sq)    0.7678
%
%   -----------------------------------参数估计-----------------------------------
%      变量               估计值            标准误             t值          p值
%     常数项             30.9428        2011.1117           0.0154      0.9883
%        X1              0.7040           0.6405           1.0992      0.3218
%        X2             -0.8487          29.1537          -0.0291      0.9779
%     X1*X2             -0.0058           0.0044          -1.3132      0.2461
%     X1*X1              0.0003           0.0003           0.8384      0.4400
%     X2*X2              0.0052           0.1055           0.0492      0.9626
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/22 21:41:00 $

if nargin < 2
   error('至少需要两个输入参数');
end
p = size(X,2);    % X的列数，即变量个数
if nargin < 3 || isempty(model)
   model = 'linear';    % model参数的默认值
end

% 生成变量标签varnames
if nargin < 4 || isempty(varnames)
    varname1 = strcat({'X'},num2str([1:p]'));
    varnames = makevarnames(varname1,model);    % 默认的变量标签
else
    if ischar(varnames)
        varname1 = cellstr(varnames);
    elseif iscell(varnames)
        varname1 = varnames(:);
    else
        error('varnames 必须是字符矩阵或字符串元胞数组');
    end
    if size(varname1,1) ~= p
        error('变量标签数与X的列数不一致');
    else
        varnames = makevarnames(varname1,model);    % 指定的变量标签
    end
end

ST = regstats(y,X,model);    % 调用regstats函数进行线性回归分析，返回结构体变量ST
f = ST.fstat;    % F检验相关结果
t = ST.tstat;    % t检验相关结果

% 显示方差分析表
fprintf('\n');
fprintf('------------------------------------方差分析表------------------------------------');
fprintf('\n');
fprintf('%s%7s%15s%15s%15s%12s','方差来源','自由度','平方和','均方','F值','p值');
fprintf('\n');
fmt = '%s%13.4f%17.4f%17.4f%16.4f%12.4f';
fprintf(fmt,'回归',f.dfr,f.ssr,f.ssr/f.dfr,f.f,f.pval);
fprintf('\n');
fmt = '%s%13.4f%17.4f%17.4f';
fprintf(fmt,'残差',f.dfe,f.sse,f.sse/f.dfe);
fprintf('\n');
fmt = '%s%13.4f%17.4f';
fprintf(fmt,'总计',f.dfe+f.dfr,f.sse+f.ssr);
fprintf('\n');
fprintf('\n');

% 显示判定系数等统计量
fmt = '%22s%15.4f%25s%10.4f';
fprintf(fmt,'均方根误差(Root MSE)',sqrt(ST.mse),'判定系数(R-Square)',ST.rsquare);
fprintf('\n');
fprintf(fmt,'因变量均值(Dependent Mean)',mean(y),'调整的判定系数(Adj R-Sq)',ST.adjrsquare);
fprintf('\n');
fprintf('\n');

% 显示参数估计及t检验相关结果
fprintf('-----------------------------------参数估计-----------------------------------');
fprintf('\n');
fprintf('%8s%18s%15s%15s%12s','变量','估计值','标准误','t值','p值');
fprintf('\n');
for i = 1:size(t.beta,1)
    if i == 1
        fmt = '%8s%20.4f%17.4f%17.4f%12.4f\n';
        fprintf(fmt,'常数项',t.beta(i),t.se(i),t.t(i),t.pval(i));
    else
        fmt = '%10s%20.4f%17.4f%17.4f%12.4f\n';
        fprintf(fmt,varnames{i-1},t.beta(i),t.se(i),t.t(i),t.pval(i));
    end
end

if nargout == 1
    stats = ST;    % 返回一个包括了回归分析的所有诊断统计量的结构体变量
end

% -----------------子函数-----------------------
function varnames = makevarnames(varname1,model)
% 生成指定模型的变量标签
p = size(varname1,1);
varname2 = [];
for i = 1:p-1
    varname2 = [varname2;strcat(varname1(i),'*',varname1(i+1:end))];
end
varname3 = strcat(varname1,'*',varname1);
switch model
    case 'linear'
        varnames = varname1;
    case 'interaction'
        varnames = [varname1;varname2];
    case 'quadratic'
        varnames = [varname1;varname2;varname3];
    case 'purequadratic'
        varnames = [varname1;varname3];
end