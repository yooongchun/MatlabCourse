%--------------------------------------------------------------------------
%              调用smoothts函数对金融时间序列数据进行平滑处理
%--------------------------------------------------------------------------

%*********************读取金融时间序列数据，绘制波形图************************
x=load('examp03_02.txt');  % 从文件examp03_02.xls中读取数据
price = x(:,4)';  % 提取矩阵x的第4列数据，即收盘价数据
figure;  % 新建一个图形窗口
plot(price,'k','LineWidth',2);  % 绘制日收盘价曲线图，黑色实线，线宽为2
xlabel('观测序号'); ylabel('上海股市日收盘价'); % 为X轴和Y轴加标签


%*****************利用盒子法对数据进行平滑处理，绘制平滑波形图****************
output1 = smoothts(price,'b',30);  % 用盒子法平滑数据，窗宽为30
output2 = smoothts(price,'b',100);  % 用盒子法平滑数据，窗宽为100
figure;  % 新建一个图形窗口
plot(price,'.');  % 绘制日收盘价散点图
hold on
plot(output1,'k','LineWidth',2);  % 绘制平滑后曲线图，黑色实线，线宽为2
plot(output2,'k-.','LineWidth',2);  % 绘制平滑后曲线图，黑色点划线，线宽为2
xlabel('观测序号'); ylabel('Box method'); % 为X轴和Y轴加标签
% 为图形加标注框
legend('原始散点','平滑曲线(窗宽30)','平滑曲线(窗宽100)','location','northwest');


%****************利用高斯窗方法对数据进行平滑处理，绘制平滑波形图**************
output3 = smoothts(price,'g',30);  % 窗宽为30，标准差为默认值0.65
output4 = smoothts(price,'g',100,100);  % 窗宽为100，标准差为100
figure;  % 新建一个图形窗口
plot(price,'.');  % 绘制日收盘价散点图
hold on
plot(output3,'k','LineWidth',2);  % 绘制平滑后曲线图，黑色实线，线宽为2
plot(output4,'k-.','LineWidth',2);  % 绘制平滑后曲线图，黑色点划线，线宽为2
xlabel('观测序号'); ylabel('Gaussian window method'); % 为X轴和Y轴加标签
legend('原始散点','平滑曲线(窗宽30，标准差0.65)',...
          '平滑曲线(窗宽100，标准差100)','location','northwest');


%*****************利用指数法对数据进行平滑处理，绘制平滑波形图****************
output5 = smoothts(price,'e',30);  % 用指数法平滑数据，窗宽为30
output6 = smoothts(price,'e',100);  % 用指数法平滑数据，窗宽为100
figure;  % 新建一个图形窗口
plot(price,'.');  % 绘制日收盘价散点图
hold on
plot(output5,'k','LineWidth',2);  % 绘制平滑后曲线图，黑色实线，线宽为2
plot(output6,'k-.','LineWidth',2);  % 绘制平滑后曲线图，黑色点划线，线宽为2
xlabel('观测序号'); ylabel('Exponential method'); % 为X轴和Y轴加标签
legend('原始散点','平滑曲线(窗宽30)','平滑曲线(窗宽100)','location','northwest');