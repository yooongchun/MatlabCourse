%--------------------------------------------------------------------------
%             读取原始数据，调用robustfit函数作稳健回归
%--------------------------------------------------------------------------

%*****************************读取数据**************************************
ClimateData = xlsread('examp08_01.xls');    % 从Excel文件读取数据
x = ClimateData(:, 1);    % 提取ClimateData的第1列，即年平均气温数据
y = ClimateData(:, 5);    % 提取ClimateData的第5列，即全年日照时数数据

%************************调用robustfit函数作稳健回归*************************
[b, stats] = robustfit(x, y)    % 返回系数的估计值b和相关统计量stats

stats.p    % 查看常数项和回归系数的t检验的p值


%**************************绘制残差和权重的散点图****************************
figure;    % 新建一个图形窗口
plot(stats.resid,  stats.w, 'o')    % 绘制残差和权重的散点图
xlabel('残差')    % 为X轴加标签
ylabel('权重')    % 为Y轴加标签


%***************绘制regress函数和robustfit函数对应的回归直线*****************
[xsort, id] = sort(x);    % 为了后面画图的需要，将x从小到大排序
ysort = y(id);    % 将y按与x相同的方式排序
xdata = [ones(size(xsort, 1), 1), xsort];    % 在原始数据x的左边加一列1
b1 = regress(ysort, xdata);    % 调用regress函数作一元线性回归
yhat1 = xdata*b1;    % 求regress函数对应的y的估计值

b2 = robustfit(xsort, ysort);    % 调用robustfit函数作稳健的一元线性回归
yhat2 = xdata*b2;    % 求robustfit函数对应的y的估计值
plot(x, y, 'ko')    % 画原始数据散点
hold on    % 图形叠加
plot(xsort, yhat1, 'r--','linewidth',3)   % 画regress函数对应的回归直线，红色虚线
plot(xsort, yhat2, 'linewidth', 3)    % 画robustfit函数对应的回归直线，蓝色实线
% 为图形加标注框
legend('原始数据散点','regress函数对应的回归直线','robustfit函数对应的回归直线');
xlabel('年平均气温(x)')    % 为x轴加标签
ylabel('全年日照时数(y)')    % 为y轴加标签