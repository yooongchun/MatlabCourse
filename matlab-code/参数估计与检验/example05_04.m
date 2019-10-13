%--------------------------------------------------------------------------
%                               核密度估计
%--------------------------------------------------------------------------

%*****************************读取文件中数据********************************
% 读取文件examp02_14.xls的第1个工作表中的G2:G52中的数据，即总成绩数据
score = xlsread('examp02_14.xls','Sheet1','G2:G52');
% 去掉总成绩中的0，即缺考成绩
score = score(score > 0);


%*****************绘制频率直方图、核密度估计图、正态分布密度图****************
% 调用ecdf函数计算xc处的经验分布函数值f_ecdf
[f_ecdf, xc] = ecdf(score);
% 新建图形窗口，然后绘制频率直方图，直方图对应7个小区间
figure;
ecdfhist(f_ecdf, xc, 7);
hold on;
xlabel('考试成绩');  % 为X轴加标签
ylabel('f(x)');  % 为Y轴加标签

% 调用ksdensity函数进行核密度估计
[f_ks1,xi1,u1] = ksdensity(score);
% 绘制核密度估计图，并设置线条为黑色实线，线宽为3
plot(xi1,f_ks1,'k','linewidth',3)

ms = mean(score);  % 计算平均成绩
ss = std(score);  % 计算成绩的标准差
% 计算xi1处的正态分布密度函数值，正态分布的均值为ms，标准差为ss
f_norm = normpdf(xi1,ms,ss); 
% 绘制正态分布密度函数图，并设置线条为红色点划线，线宽为3
plot(xi1,f_norm,'r-.','linewidth',3)

% 为图形加标注框，标注框的位置在坐标系的左上角
legend('频率直方图','核密度估计图', '正态分布密度图', 'Location','NorthWest')
u1    %查看默认窗宽



%**********************绘制不同窗宽对应的核密度函数图************************
% 设置窗宽分别为0.1，1，5和9，调用ksdensity函数进行核密度估计
[f_ks1,xi1] = ksdensity(score,'width',0.1);
[f_ks2,xi2] = ksdensity(score,'width',1);
[f_ks3,xi3] = ksdensity(score,'width',5);
[f_ks4,xi4] = ksdensity(score,'width',9);
figure;  % 新建图形窗口

% 分别绘制不同窗宽对应的核密度估计图，它们对应不同的线型和颜色
plot(xi1,f_ks1,'c-.','linewidth',2);
hold on;
xlabel('考试成绩');  % 为X轴加标签
ylabel('核密度估计');  % 为Y轴加标签
plot(xi2,f_ks2,'r:','linewidth',2);
plot(xi3,f_ks3,'k','linewidth',2);
plot(xi4,f_ks4,'b--','linewidth',2);

% 为图形加标注框，标注框的位置在坐标系的左上角
legend('窗宽为0.1','窗宽为1','窗宽为5','窗宽为9','Location','NorthWest');



%**********************绘制不同核函数对应的核密度函数图**********************
% 设置核函数分别为Gaussian、Uniform、Triangle和Epanechnikov核函数，
% 调用ksdensity函数进行核密度估计
[f_ks1,xi1] = ksdensity(score,'kernel','normal');
[f_ks2,xi2] = ksdensity(score,'kernel','box');
[f_ks3,xi3] = ksdensity(score,'kernel','triangle');
[f_ks4,xi4] = ksdensity(score,'kernel','epanechnikov');
figure;  % 新建图形窗口

% 分别绘制不同核函数对应的核密度估计图，它们对应不同的线型和颜色
plot(xi1,f_ks1,'k','linewidth',2)
hold on
xlabel('考试成绩');  % 为X轴加标签
ylabel('核密度估计');  % 为Y轴加标签
plot(xi2,f_ks2,'r:','linewidth',2)
plot(xi3,f_ks3,'b-.','linewidth',2)
plot(xi4,f_ks4,'c--','linewidth',2)

% 为图形加标注框，标注框的位置在坐标系的左上角
legend('Gaussian','Uniform','Triangle','Epanechnikov','Location','NorthWest');



%***************绘制经验分布函数、估计的分布函数和理论正态分布图***************
figure;   % 新建图形窗口
% 绘制经验分布函数图，并返回图形句柄h和结构体变量stats，
% 结构体变量stats有5个字段，分别对应最小值、最大值、平均值、中位数和标准差
[h,stats] = cdfplot(score);

% 设置线条为红色虚线，线宽为2
set(h,'color','r', 'LineStyle', ':','LineWidth',2);
hold on
title ('');  % 去掉图中标题
xlabel('考试成绩');  % 为X轴加标签
ylabel('F(x)');  % 为Y轴加标签

% 调用ksdensity函数对累积分布函数进行估计
[f_ks, xi] = ksdensity(score,'function','cdf');
% 绘制估计的分布函数图，并设置线条为黑色实线，线宽为2
plot(xi,f_ks,'k','linewidth',2);

% 计算均值为stats.mean，标准差为stats.std的正态分布在向量xi处的分布函数值
y = normcdf(xi,stats.mean,stats.std);
% 绘制正态分布的分布函数曲线，并设置线条为蓝色点划线，线宽为2
plot(xi,y,'b-.','LineWidth',2);

% 添加标注框，并设置标注框的位置在图形窗口的左上角
legend('经验分布函数', '估计的分布函数','理论正态分布','Location','NorthWest');
