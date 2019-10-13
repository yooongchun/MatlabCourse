%--------------------------------------------------------------------------
%                           分布的拟合与检验
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%                         描述性统计量和统计图
%--------------------------------------------------------------------------

%*****************************读取文件中数据********************************
% 读取文件examp02_14.xls的第1个工作表中的G2:G52中的数据，即总成绩数据
score = xlsread('examp02_14.xls','Sheet1','G2:G52');
% 去掉总成绩中的0，即缺考成绩
score = score(score > 0);

%****************************计算描述性统计量*******************************
score_mean = mean(score)  % 计算平均成绩

s1 = std(score)  % 计算(5.1)式的标准差
s1 = std(score,0)  % 也是计算(5.1)式的标准差
s2 = std(score,1)  % 计算(5.2)式的标准差

score_max = max(score)    % 计算样本最大值

score_min = min(score)    % 计算样本最小值

score_range = range(score)    % 计算样本极差

score_median = median(score)    % 计算样本中位数

score_mode = mode(score)    % 计算样本众数

score_cvar = std(score)/mean(score)    % 计算变异系数

score_skewness = skewness(score)    % 计算样本偏度

score_kurtosis = kurtosis(score)    % 计算样本峰度


%*******************************绘制箱线图**********************************
figure;    % 新建图形窗口
boxlabel = {'考试成绩箱线图'};    % 箱线图的标签
% 绘制带有刻槽的水平箱线图
boxplot(score,boxlabel,'notch','on','orientation','horizontal')
xlabel('考试成绩');  % 为X轴加标签

%*****************************绘制频率直方图********************************
% 调用ecdf函数计算xc处的经验分布函数值f
[f, xc] = ecdf(score);
figure;    % 新建图形窗口
% 绘制频率直方图
ecdfhist(f, xc, 7);
xlabel('考试成绩');  % 为X轴加标签
ylabel('f(x)');  % 为Y轴加标签

%************************绘制理论正态分布密度函数图**************************
% 产生一个新的横坐标向量x
x = 40:0.5:100;
% 计算均值为mean(score)，标准差为std(score)的正态分布在向量x处的密度函数值
y = normpdf(x,mean(score),std(score));
hold on
plot(x,y,'k','LineWidth',2) % 绘制正态分布的密度函数曲线，并设置线条为黑色实线，线宽为2
% 添加标注框，并设置标注框的位置在图形窗口的左上角
legend('频率直方图','正态分布密度曲线','Location','NorthWest');

%**************************绘制经验分布函数图*******************************
figure;    % 新建图形窗口
% 绘制经验分布函数图，并返回图形句柄h和结构体变量stats，
% 结构体变量stats有5个字段，分别对应最小值、最大值、平均值、中位数和标准差
[h,stats] = cdfplot(score)
set(h,'color','k','LineWidth',2);    % 设置线条颜色为黑色，线宽为2

%************************绘制理论正态分布函数图******************************
x = 40:0.5:100;    % 产生一个新的横坐标向量x
% 计算均值为stats.mean，标准差为stats.std的正态分布在向量x处的分布函数值
y = normcdf(x,stats.mean,stats.std);
hold on
% 绘制正态分布的分布函数曲线，并设置线条为品红色虚线，线宽为2
plot(x,y,':k','LineWidth',2);
% 添加标注框，并设置标注框的位置在图形窗口的左上角
legend('经验分布函数','理论正态分布','Location','NorthWest');

%*****************************绘制正态概率图********************************
figure;    % 新建图形窗口
normplot(score);    % 绘制正态概率图




%--------------------------------------------------------------------------
%                               分布的检验
%--------------------------------------------------------------------------

%*****************************读取文件中数据********************************
% 读取文件examp02_14.xls的第1个工作表中的G2:G52中的数据，即总成绩数据
score = xlsread('examp02_14.xls','Sheet1','G2:G52');
% 去掉总成绩中的0，即缺考成绩
score = score(score > 0);


%*******************调用chi2gof函数进行卡方拟合优度检验***********************
% 进行卡方拟合优度检验
[h,p,stats] = chi2gof(score)

% 指定各初始小区间的中点
ctrs = [50 60 70 78 85 94];
% 指定'ctrs'参数，进行卡方拟合优度检验
[h,p,stats] = chi2gof(score,'ctrs',ctrs)

[h,p,stats] = chi2gof(score,'nbins',6)    % 指定'nbins'参数，进行卡方拟合优度检验

% 指定分布为默认的正态分布，分布参数由x进行估计
[h,p,stats] = chi2gof(score,'nbins',6);
% 求平均成绩ms和标准差ss
ms = mean(score);
ss = std(score);
% 参数'cdf'的值是由函数名字符串与函数中所含参数的参数值构成的元胞数组
[h,p,stats] = chi2gof(score,'nbins',6,'cdf',{'normcdf', ms, ss});
% 参数'cdf'的值是由函数句柄与函数中所含参数的参数值构成的元胞数组
[h,p,stats] = chi2gof(score,'nbins',6,'cdf',{@normcdf, ms, ss});
% 同时指定'cdf'和'nparams'参数
[h,p,stats] = chi2gof(score,'nbins',6,'cdf',{@normcdf,ms,ss},'nparams',2)

[h,p] = chi2gof(score,'cdf',@normcdf) % 调用chi2gof函数检验数据是否服从标准正态分布

% 指定初始分组数为6，检验总成绩数据是否服从参数为ms = 79的泊松分布
[h,p] = chi2gof(score,'nbins',6,'cdf',{@poisscdf, ms})

% 指定初始分组数为6，最小理论频数为3，检验总成绩数据是否服从正态分布
h = chi2gof(score,'nbins',6,'cdf',{@normcdf, ms, ss},'emin',3)


%*************************调用jbtest函数进行正态性检验***********************
randn('seed',0)  % 指定随机数生成器的初始种子为0
x = randn(10000,1);  % 生成10000个服从标准正态分布的随机数
h = jbtest(x)  % 调用jbtest函数进行正态性检验

x(end) = 5;  % 将向量x的最后一个元素改为5
h = jbtest(x)  % 再次调用jbtest函数进行正态性检验

% 调用jbtest函数进行Jarque-Bera检验
[h,p,jbstat,critval] = jbtest(score)


%*************************调用kstest函数进行正态性检验***********************
% 生成cdf矩阵，用来指定分布：均值为79，标准差为10.1489的正态分布
cdf = [score, normcdf(score, 79, 10.1489)];
% 调用kstest函数，检验总成绩是否服从由cdf指定的分布
[h,p,ksstat,cv] = kstest(score,cdf)


%*************调用kstest2函数检验两个班的总成绩是否服从相同的分布*************
% 读取文件examp02_14.xls的第1个工作表中的B2:B52中的数据，即班级数据
banji = xlsread('examp02_14.xls','Sheet1','B2:B52');
% 读取文件examp02_14.xls的第1个工作表中的G2:G52中的数据，即总成绩数据
score = xlsread('examp02_14.xls','Sheet1','G2:G52');
% 去除缺考数据
score = score(score > 0);
banji = banji(score > 0);
% 分别提取60101和60102班的总成绩
score1 = score(banji == 60101);
score2 = score(banji == 60102);
% 调用kstest2函数检验两个班的总成绩是否服从相同的分布
[h,p,ks2stat] = kstest2(score1,score2)


%*******************分别绘制两个班的总成绩的经验分布图***********************
figure;    % 新建图形窗口
% 绘制60101班总成绩的经验分布函数图
F1 = cdfplot(score1);
% 设置线宽为2，颜色为红色
set(F1,'LineWidth',2,'Color','r')
hold on
% 绘制60102班总成绩的经验分布函数图
F2 = cdfplot(score2);
% 设置线型为点划线，线宽为2，颜色为黑色
set(F2,'LineStyle','-.','LineWidth',2,'Color','k')
% 为图形加标注框，标注框的位置在坐标系的左上角
legend('60101班总成绩的经验分布函数','60102班总成绩的经验分布函数',...
          'Location','NorthWest')


%*************************调用kstest2函数进行正态性检验***********************
randn('seed',0)  % 指定随机数生成器的初始种子为0
% 产生10000个服从均值为79，标准差为10.1489的正态分布的随机数，构成一个列向量x
x = normrnd(mean(score),std(score),10000,1);
% 调用kstest2函数检验总成绩数据score与随机数向量x是否服从相同的分布
[h,p] = kstest2(score,x,0.05)


%**********************调用lillietest函数进行分布的检验**********************
% 调用lillietest函数进行Lilliefors检验，检验总成绩数据是否服从正态分布
[h,p,kstat,critval] = lillietest(score)

% 调用lillietest函数进行Lilliefors检验，检验总成绩数据是否服从指数分布
[h, p] = lillietest(score,0.05,'exp')
