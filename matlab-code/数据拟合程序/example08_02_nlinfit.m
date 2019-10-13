%--------------------------------------------------------------------------
%             读取原始数据，调用nlinfit函数作一元非线性回归
%--------------------------------------------------------------------------

%***************************读取数据，绘制散点图*****************************
HeadData = xlsread('examp08_02.xls');    %从Excel文件读取数据
x = HeadData(:, 4);    % 提取HeadData矩阵的第4列数据，即年龄数据
y = HeadData(:, 9);    % 提取HeadData矩阵的第9列数据，即头围数据
plot(x, y, 'k.')    % 绘制x和y的散点图
xlabel('年龄(x)')    % 为X轴加标签
ylabel('头围(y)')    % 为Y轴加标签


%***********************调用nlinfit函数作一元非线性回归**********************
HeadData = xlsread('examp08_02.xls');    % 从Excel文件读取数据
HeadData = sortrows(HeadData, 4);    % 为作图需要，将HeadData按第4列从小到大排序
x = HeadData(:, 4);    % 提取排序后年龄数据
y = HeadData(:, 9);    % 提取排序后头围数据
options = statset;     % 创建一个结构体变量，用来设定迭代算法的控制参数
options.Robust = 'on';    % 调用稳健拟合方法
% 调用nlinfit函数作非线性回归
[beta,r,J,COVB,mse] = nlinfit(x,y,@HeadCir1,[53,-0.2604,0.6276], options); 
%[beta,r,J,COVB,mse] = nlinfit(x,y,'HeadCir1',[53,-0.2604,0.6276],options);

%HeadCir2 = @(beta, x)beta(1)*exp(beta(2)./(x+beta(3)));    % 定义匿名函数
%[beta,r,J,COVB,mse] = nlinfit(x,y,HeadCir2,[53,-0.2604,0.6276],options);
beta    %查看未知参数估计值
mse    % 查看均方残差平方和


%**************************绘制一元非线性回归曲线****************************
yhat = HeadCir1(beta, x);    % 求y的估计值
figure    % 新建一个空的图形窗口
plot(x, y, 'k.')    % 绘制x和y的散点图
hold on

% 绘制robustfit函数对应的回归直线，蓝色实线，线宽为3
plot(x, yhat, 'linewidth', 3)
xlabel('年龄(x)')    % 给X轴加标签
ylabel('头围(y)')    % 给Y轴加标签
legend('原始数据散点','非线性回归曲线')    % 为图形加标注框


%**************************参数估计值的置信区间*****************************
% 求参数估计值的95%置信区间的第1种方式
ci1 = nlparci(beta, r, 'covar', COVB, 'alpha', 0.05) 

% 求参数估计值的95%置信区间的第2种方式
ci1 = nlparci(beta, r, 'jacobian', J, 'alpha', 0.05) 


%**************************绘制头围观测值的预测区间**************************
xx =[0:0.1:16]';    % 设定年龄向量

% 计算给定年龄处头围预测值和预测区间
[ypred,delta] = nlpredci(@HeadCir1,xx,beta,r,'covar',COVB,'mse',mse, ...
                            'predopt','observation');

yup = ypred + delta;    % 预测区间上限（线）
ydown = ypred - delta;    % 预测区间下限（线）

figure    % 新建一个空的图形窗口
hold on
h1 = fill([xx; flipud(xx)],[yup; flipud(ydown)],[0.5,0.5,0.5]);   % 填充预测区间
set(h1,'EdgeColor','none','FaceAlpha',0.5);   % 设置填充区域边界线条颜色和面板透明度

plot(xx,yup,'r--','LineWidth',2);    % 画预测区间上限曲线，红色虚线
plot(xx,ydown,'b-.','LineWidth',2);    % 画预测区间下限曲线，蓝色点划线
plot(xx, ypred, 'k','linewidth', 2)    % 画回归曲线，黑色实线

grid on    % 添加辅助网格
ylim([32, 57])    % 设置y轴的显示范围为32至57
xlabel('年龄(x)')    % 给X轴加标签
ylabel('头围(y)')    % 给Y轴加标签
h2 = legend('预测区间','预测区间上限','预测区间下限','回归曲线');    % 为图形加标注框
set(h2, 'Location', 'SouthEast')    % 设置标注框的放置位置为图形窗口右下角