%--------------------------------------------------------------------------
%               创建一个Microsoft Excel服务器，插入内部图片
%--------------------------------------------------------------------------

% 创建一个Microsoft Excel服务器，返回句柄Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % 设置服务器为可见状态
Workbook = Excel.Workbooks.Add;    % 新建一个工作簿，返回其句柄
Sheet1 = Workbook.Sheets.Item(1);    % 返回第1个工作表的句柄Sheet1

data = normrnd(75,4,1000,1);    % 生成1000个均值为75，标准差为4的正态分布随机数
% 新建一个图形窗口，设置图形窗口为不可见，并返回图形窗口句柄
zft = figure('units','normalized','position',...
                [0.280469 0.553385 0.428906 0.251302],'visible','off');
set(gca,'position',[0.1 0.2 0.85 0.75]);    % 设置当前坐标系的位置和大小
hist(data);    % 绘制正态分布随机数的频数直方图
grid on;       % 添加参考网格
xlabel('考试成绩');    % 为X轴加标签
ylabel('人数');       % 为Y轴加标签
hgexport(zft, '-clipboard');    % 将直方图复制到剪贴板

% 选中工作表Sheet1的A2单元格，插入由MATLAB命令作出的直方图
Sheet1.Range('A2').Select;
Sheet1.Paste

% 选中工作表Sheet1的E11单元格，插入由MATLAB命令作出的直方图
Sheet1.Range('E11').Select;
Sheet1.PasteSpecial;

% 在工作表Sheet1的I20单元格处插入由MATLAB命令作出的直方图
Sheet1. Range('I20').PasteSpecial;