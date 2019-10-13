function  piva = PiMonteCarlo(n)
%   PiMonteCarlo(n)，用随机投点法模拟圆周率pi，作出模拟图. n为投点次数，可以是非负整数标量
%   或向量.

%   piva = PiMonteCarlo(n)，用随机投点法模拟圆周率pi，返回模拟值piva. 若n为标量（向
%   量），则piva也为标量（向量）.

x = 0;y = 0;d = 0;
m = length(n);  % 求变量n的长度
pivalue = zeros(m,1);  % 为变量pivalue赋初值
% 通过循环用投点法模拟圆周率pi
for i = 1:m
   x = 2*rand(n(i),1)-1;  % 随机投点的横坐标
   y = 2*rand(n(i),1)-1;  % 随机投点的纵坐标
   d = x.^2+y.^2;
   pivalue(i) = 4*sum(d <= 1)/n(i);  % 圆周率的模拟值
end

if nargout == 0
    % 不输出圆周率的模拟值，返回模拟图
    if m > 1
        % 如果n为向量，则返回圆周率的模拟值与投点个数的散点图
        figure;  % 新建一个图形窗口
        plot(n,pivalue,'k.');  % 绘制散点图
        h = refline(0,pi);   % 添加参考线
        set(h,'linewidth',2,'color','k');  % 设置参考线属性
        text(1.05*n(end),pi,'\pi','fontsize',15);  % 添加文本信息
        xlabel('投点个数');  ylabel('\pi的模拟值'); % 添加坐标轴标签
    else
        % 如果n为标量，则返回投点法模拟圆周率的示意图
        figure;  % 新建一个图形窗口
        plot(x,y,'k.');  % 绘制散点图
        hold on;
        % 绘制边长为2的正方形
        h = rectangle('Position',[-1 -1 2 2],'LineWidth',2);
        t = linspace(0,2*pi,100);  % 定义一个角度向量
        plot(cos(t),sin(t),'k','linewidth',2);  % 绘制单位圆
        xlabel('X');  ylabel('Y');  % 添加坐标轴标签
        title(['Pi的模拟值： ' num2str(pivalue)]); % 添加标题
        axis([-1.1 1.1 -1.1 1.1]); axis equal;  % 设置坐标轴属性
    end
else    
    piva = pivalue;  % 输出圆周率的模拟值
end