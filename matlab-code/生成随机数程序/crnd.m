function y = crnd(pdffun, pdfdef, m, n)
%生成任意一元连续分布随机数
%   y = crnd(pdffun, pdfdef, m, n)，产生指定一元连续分布的随机数，m行n列。pdffun为密度
%   函数表达式，pdfdef为密度函数定义域。注意：pdfdef只能是有限区间，若密度函数定义域为无限区
%   间，应设成比较大的有限区间，例如[-10000,10000]
%
%   example:
%   pdffun = 'x*(x>=0 & x<1)+(2-x)*(x>=1 & x<2)';
%   x = crnd(pdffun, [0 2], 1000, 1);
%   [fp,xp] = ecdf(x);
%   ecdfhist(fp, xp, 20);
%   hold on
%   fplot(pdffun, [0 2], 'r')
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/17 12:10:00 $

fun = vectorize(['(' pdffun ')' '*x']);    % x*f(x)运算向量化
try
    xm = quadl(fun, min(pdfdef), max(pdfdef));    % 计算x的数学期望xm
catch
    xm = mean(pdfdef);    % 计算定义区间的平均值xm
end

pdffun = vectorize(['(' pdffun ')' '*x/x']);    % x*f(x)/x运算向量化
cdfrnd = rand(m*n, 1);    % 产生[0,1]上均匀分布随机数
y = zeros(m*n, 1);        % 产生0向量作为变量y的初值
options = optimset;       % 产生一个控制迭代过程的结构体变量
options.Display = 'off';  % 不显示中间迭代过程
% 通过循环计算指定一元连续分布的随机数
for i = 1:m*n
    funcdf = @(x)[quadl(pdffun, min(pdfdef), x) - cdfrnd(i)];
    y(i) = fsolve(funcdf, xm, options);
end
y=reshape(y,[m,n]);    % 把向量y变为矩阵