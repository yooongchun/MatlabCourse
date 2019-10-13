%--------------------------------------------------------------------------
%                         Copula理论及应用实例
%--------------------------------------------------------------------------

%******************************读取数据*************************************
% 从文件hushi.xls中读取数据
hushi = xlsread('hushi.xls');
% 提取矩阵hushi的第5列数据，即沪市的日收益率数据
X = hushi(:,5);
% 从文件shenshi.xls中读取数据
shenshi = xlsread('shenshi.xls');
% 提取矩阵shenshi的第5列数据，即深市的日收益率数据
Y = shenshi(:,5);


%****************************绘制频率直方图*********************************
% 调用ecdf函数和ecdfhist函数绘制沪、深两市日收益率的频率直方图
[fx, xc] = ecdf(X);
figure;
ecdfhist(fx, xc, 30);
xlabel('沪市日收益率');  % 为X轴加标签
ylabel('f(x)');  % 为Y轴加标签
[fy, yc] = ecdf(Y);
figure;
ecdfhist(fy, yc, 30);
xlabel('深市日收益率');  % 为X轴加标签
ylabel('f(y)');  % 为Y轴加标签


%****************************计算偏度和峰度*********************************
% 计算X和Y的偏度
xs = skewness(X)
ys = skewness(Y)

% 计算X和Y的峰度
kx = kurtosis(X)
ky = kurtosis(Y)


%******************************正态性检验***********************************
% 分别调用jbtest、kstest和lillietest函数对X进行正态性检验
[h,p] = jbtest(X)  % Jarque-Bera检验
[h,p] = kstest(X,[X,normcdf(X,mean(X),std(X))])  % Kolmogorov-Smirnov检验
[h, p] = lillietest(X)  % Lilliefors检验

% 分别调用jbtest、kstest和lillietest函数对Y进行正态性检验
[h,p] = jbtest(Y)  % Jarque-Bera检验
[h,p] = kstest(Y,[Y,normcdf(Y,mean(Y),std(Y))])  % Kolmogorov-Smirnov检验
[h, p] = lillietest(Y)  % Lilliefors检验


%****************************求经验分布函数值*******************************
% 调用ecdf函数求X和Y的经验分布函数
[fx, Xsort] = ecdf(X);
[fy, Ysort] = ecdf(Y);
% 调用spline函数，利用样条插值法求原始样本点处的经验分布函数值
U1 = spline(Xsort(2:end),fx(2:end),X);
V1 = spline(Ysort(2:end),fy(2:end),Y);

% 调用ecdf函数求X和Y的经验分布函数
[fx, Xsort] = ecdf(X);
[fy, Ysort] = ecdf(Y);
% 提取fx和fy的第2个至最后一个元素，即排序后样本点处的经验分布函数值
fx = fx(2:end);
fy = fy(2:end);

% 通过排序和反排序恢复原始样本点处的经验分布函数值U1和V1
[Xsort,id] = sort(X);
[idsort,id] = sort(id);
U1 = fx(id);
[Ysort,id] = sort(Y);
[idsort,id] = sort(id);
V1 = fy(id);


%*******************************核分布估计**********************************
% 调用ksdensity函数分别计算原始样本X和Y处的核分布估计值
U2 = ksdensity(X,X,'function','cdf');
V2 = ksdensity(Y,Y,'function','cdf');


% **********************绘制经验分布函数图和核分布估计图**********************
[Xsort,id] = sort(X);  % 为了作图的需要，对X进行排序
figure;  % 新建一个图形窗口
plot(Xsort,U1(id),'c','LineWidth',5); % 绘制沪市日收益率的经验分布函数图
hold on
plot(Xsort,U2(id),'k-.','LineWidth',2); % 绘制沪市日收益率的核分布估计图
legend('经验分布函数','核分布估计', 'Location','NorthWest'); % 加标注框
xlabel('沪市日收益率');  % 为X轴加标签
ylabel('F(x)');  % 为Y轴加标签

[Ysort,id] = sort(Y);  % 为了作图的需要，对Y进行排序
figure;  % 新建一个图形窗口
plot(Ysort,V1(id),'c','LineWidth',5); % 绘制深市日收益率的经验分布函数图
hold on
plot(Ysort,V2(id),'k-.','LineWidth',2); % 绘制深市日收益率的核分布估计图
legend('经验分布函数','核分布估计', 'Location','NorthWest'); % 加标注框
xlabel('深市日收益率');  % 为X轴加标签
ylabel('F(x)');  % 为Y轴加标签


%****************************绘制二元频数直方图*****************************
% 调用ksdensity函数分别计算原始样本X和Y处的核分布估计值
U = ksdensity(X,X,'function','cdf');
V = ksdensity(Y,Y,'function','cdf');
figure;  % 新建一个图形窗口
% 绘制边缘分布的二元频数直方图，
hist3([U(:) V(:)],[30,30])
xlabel('U（沪市）');  % 为X轴加标签
ylabel('V（深市）');  % 为Y轴加标签
zlabel('频数');  % 为z轴加标签


%****************************绘制二元频率直方图*****************************
figure;  % 新建一个图形窗口
% 绘制边缘分布的二元频数直方图，
hist3([U(:) V(:)],[30,30])
h = get(gca, 'Children');  % 获取频数直方图的句柄值
cuv = get(h, 'ZData');  % 获取频数直方图的Z轴坐标
set(h,'ZData',cuv*30*30/length(X));  % 对频数直方图的Z轴坐标作变换
xlabel('U（沪市）');  % 为X轴加标签
ylabel('V（深市）');  % 为Y轴加标签
zlabel('c(u,v)');  % 为z轴加标签


%***********************求Copula中参数的估计值******************************
% 调用copulafit函数估计二元正态Copula中的线性相关参数
rho_norm = copulafit('Gaussian',[U(:), V(:)])
% 调用copulafit函数估计二元t-Copula中的线性相关参数和自由度
[rho_t,nuhat,nuci] = copulafit('t',[U(:), V(:)])


%********************绘制Copula的密度函数和分布函数图************************
[Udata,Vdata] = meshgrid(linspace(0,1,31));  % 为绘图需要，产生新的网格数据
% 调用copulapdf函数计算网格点上的二元正态Copula密度函数值
Cpdf_norm = copulapdf('Gaussian',[Udata(:), Vdata(:)],rho_norm);
% 调用copulacdf函数计算网格点上的二元正态Copula分布函数值
Ccdf_norm = copulacdf('Gaussian',[Udata(:), Vdata(:)],rho_norm);
% 调用copulapdf函数计算网格点上的二元t-Copula密度函数值
Cpdf_t = copulapdf('t',[Udata(:), Vdata(:)],rho_t,nuhat);
% 调用copulacdf函数计算网格点上的二元t-Copula分布函数值
Ccdf_t = copulacdf('t',[Udata(:), Vdata(:)],rho_t,nuhat);
% 绘制二元正态Copula的密度函数和分布函数图
figure;  % 新建图形窗口
surf(Udata,Vdata,reshape(Cpdf_norm,size(Udata)));  % 绘制二元正态Copula密度函数图
xlabel('U');  % 为X轴加标签
ylabel('V');  % 为Y轴加标签
zlabel('c(u,v)');  % 为z轴加标签
figure;  % 新建图形窗口
surf(Udata,Vdata,reshape(Ccdf_norm,size(Udata)));  % 绘制二元正态Copula分布函数图
xlabel('U');  % 为X轴加标签
ylabel('V');  % 为Y轴加标签
zlabel('C(u,v)');  % 为z轴加标签

% 绘制二元t-Copula的密度函数和分布函数图
figure;  % 新建图形窗口
surf(Udata,Vdata,reshape(Cpdf_t,size(Udata)));  % 绘制二元t-Copula密度函数图
xlabel('U');  % 为X轴加标签
ylabel('V');  % 为Y轴加标签
zlabel('c(u,v)');  % 为z轴加标签
figure;  % 新建图形窗口
surf(Udata,Vdata,reshape(Ccdf_t,size(Udata)));  % 绘制二元t-Copula分布函数图
xlabel('U');  % 为X轴加标签
ylabel('V');  % 为Y轴加标签
zlabel('C(u,v)');  % 为z轴加标签


%**************求Kendall秩相关系数和Spearman秩相关系数***********************
% 调用copulastat函数求二元正态Copula对应的Kendall秩相关系数
Kendall_norm = copulastat('Gaussian',rho_norm)
% 调用copulastat函数求二元正态Copula对应的Spearman秩相关系数
Spearman_norm = copulastat('Gaussian',rho_norm,'type','Spearman')
% 调用copulastat函数求二元t-Copula对应的Kendall秩相关系数
Kendall_t = copulastat('t',rho_t)
% 调用copulastat函数求二元t-Copula对应的Spearman秩相关系数
Spearman_t = copulastat('t',rho_t,'type','Spearman')

% 直接根据沪、深两市日收益率的原始观测数据，调用corr函数求Kendall秩相关系数
Kendall = corr([X,Y],'type','Kendall')
% 直接根据沪、深两市日收益率的原始观测数据，调用corr函数求Spearman秩相关系数
Spearman = corr([X,Y],'type','Spearman')


%******************************模型评价*************************************
% 调用ecdf函数求X和Y的经验分布函数
[fx, Xsort] = ecdf(X);
[fy, Ysort] = ecdf(Y);
% 调用spline函数，利用样条插值法求原始样本点处的经验分布函数值
U = spline(Xsort(2:end),fx(2:end),X);
V = spline(Ysort(2:end),fy(2:end),Y);
% 定义经验Copula函数C(u,v)
C = @(u,v)mean((U <= u).*(V <= v));
% 为作图的需要，产生新的网格数据
[Udata,Vdata] = meshgrid(linspace(0,1,31));
% 通过循环计算经验Copula函数在新产生的网格点处的函数值
for i=1:numel(Udata)
    CopulaEmpirical(i) = C(Udata(i),Vdata(i));
end

figure;  % 新建图形窗口
% 绘制经验Copula分布函数图像
surf(Udata,Vdata,reshape(CopulaEmpirical,size(Udata)))
xlabel('U');  % 为X轴加标签
ylabel('V');  % 为Y轴加标签
zlabel('Empirical Copula C(u,v)');  % 为z轴加标签

% 通过循环计算经验Copula函数在原始样本点处的函数值
CUV = zeros(size(U(:)));
for i=1:numel(U)
    CUV(i) = C(U(i),V(i));
end

% 计算线性相关参数为0.9264的二元正态Copula函数在原始样本点处的函数值
rho_norm = 0.9264;
Cgau = copulacdf('Gaussian',[U(:), V(:)],rho_norm);
% 计算线性相关参数为0.9325，自由度为4的二元t-Copula函数在原始样本点处的函数值
rho_t = 0.9325;
k = 4.0089;
Ct = copulacdf('t',[U(:), V(:)],rho_t,k);
% 计算平方欧氏距离
dgau2 = (CUV-Cgau)'*(CUV-Cgau)
dt2 = (CUV-Ct)'*(CUV-Ct)
