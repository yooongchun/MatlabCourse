function ceshi_Excel
%利用MATLAB生成Excel文档
%   ceshi_Excel
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/14 20:40:00 $

% 设定测试Excel文件名和路径
filespec_user = [pwd '\测试.xls'];

% 判断Excel是否已经打开，若已打开，就在打开的Excel中进行操作，否则就打开Excel
try
    % 若Excel服务器已经打开，返回其句柄Excel
    Excel = actxGetRunningServer('Excel.Application');
catch
    % 创建一个Microsoft Excel服务器，返回句柄Excel
    Excel = actxserver('Excel.Application'); 
end;

% 设置Excel服务器为可见状态
Excel.Visible = 1;    % set(Excel, 'Visible', 1); 

% 若测试文件存在，打开该测试文件，否则，新建一个工作簿，并保存，文件名为测试.Excel
if exist(filespec_user,'file'); 
    Workbook = Excel.Workbooks.Open(filespec_user);
    % Workbook = invoke(Excel.Workbooks,'Open',filespec_user);
else
    Workbook = Excel.Workbooks.Add;
    % Workbook = invoke(Excel.Workbooks, 'Add');
    Workbook.SaveAs(filespec_user);
end

% 返回当前工作表句柄
Sheets = Excel.ActiveWorkbook.Sheets;    % Sheets = Workbook.Sheets;
Sheet1 = Sheets.Item(1);    % 返回第1个表格句柄
Sheet1.Activate;    % 激活第1个表格

% 页面设置
Sheet1.PageSetup.TopMargin = 60;       % 上边距60磅
Sheet1.PageSetup.BottomMargin = 45;    % 下边距45磅
Sheet1.PageSetup.LeftMargin = 45;      % 左边距45磅
Sheet1.PageSetup.RightMargin = 45;     % 右边距45磅

% 设置行高和列宽
% 定义行高向量RowHeight
RowHeight = [26,22,15,29,37,29,29,25,25,36,280,31,40,29,15,24]';
% 设置Range对象（从A1到A16）的行高
Sheet1.Range('A1:A16').RowHeight = RowHeight;
% 设置Range对象（从A1到H1）的列宽
Sheet1.Range('A1:H1').ColumnWidth = [9,15,9,9,9,9,9,9];

% 合并单元格
Sheet1.Range('A1:H1').MergeCells = 1;
Sheet1.Range('A2:H2').MergeCells = 1;
Sheet1.Range('A8:A9').MergeCells = 1;
Sheet1.Range('B8:D8').MergeCells = 1;
Sheet1.Range('E8:H8').MergeCells = 1;
Sheet1.Range('B9:D9').MergeCells = 1;
Sheet1.Range('E9:H9').MergeCells = 1;
Sheet1.Range('A10:H10').MergeCells = 1;
Sheet1.Range('A11:H11').MergeCells = 1;
Sheet1.Range('A12:H12').MergeCells = 1;
Sheet1.Range('A13:H13').MergeCells = 1;
Sheet1.Range('A14:H14').MergeCells = 1;
Sheet1.Range('D16:H16').MergeCells = 1;

% 设置单元格的边框
Sheet1.Range('A4:H14').Borders.Weight = 3;
Sheet1.Range('A10:H12').Borders.Item(3).Linestyle = 0;
Sheet1.Range('A10:H12').Borders.Item(4).Linestyle = 0;
Sheet1.Range('A13:H13').Borders.Item(4).Linestyle = 0;
Sheet1.Range('A14:H14').Borders.Item(3).Linestyle = 0;

% 设置单元格对齐方式
Sheet1.Range('A1:H9').HorizontalAlignment = 3;
Sheet1.Range('A4:A9').HorizontalAlignment = 6;
Sheet1.Range('C4:C7').HorizontalAlignment = 6;
Sheet1.Range('E4:E7').HorizontalAlignment = 6;
Sheet1.Range('G4:G7').HorizontalAlignment = 6;
Sheet1.Range('A10:H10').HorizontalAlignment = 6;
Sheet1.Range('A11:H11').HorizontalAlignment = 6;    % -4130
Sheet1.Range('A11:H11').VerticalAlignment = 1;
Sheet1.Range('A12:H12').HorizontalAlignment = 4;
Sheet1.Range('A13:H13').VerticalAlignment = 1;
Sheet1.Range('A14:H14').HorizontalAlignment = 4;
Sheet1.Range('D16:H16').HorizontalAlignment = 4;

% 写入单元格内容
Sheet1.Range('A1').Value = '试  卷  分  析';
Sheet1.Range('A2').Value = '（ 2009  —  2010   学年 第一学期）';
Sheet1.Range('A4:H4').Value = {'课程名称','','课程号',...
    '','任课教师学院','','任课教师',''};
Sheet1.Range('A5:H5').Value = {'授课班级','','考试日期',...
    '','应考人数','','实考人数',''};
Sheet1.Range('A6:H6').Value = {'出卷方式','','阅卷方式',...
    '','选用试卷A/B','','考试时间',''};
Sheet1.Range('A7:H7').Value = {'考试方式','','平均分',...
    '','不及格人数','','及格率',''};
Sheet1.Range('A8').Value = '成绩分布';
Sheet1.Range('B8').Value = '90分以上       人占        %';
Sheet1.Range('E8').Value = '80---89分        人占        %';
Sheet1.Range('B9').Value = '70---79分      人占        %';
Sheet1.Range('E9').Value = '60---69分        人占        %';
Sheet1.Range('A10').Value = ['试卷分析（含是否符合教学大纲、难度、知识覆'...
    '盖面、班级分数分布分析、学生答题存在的共性问题与知识掌握情况、教学中'...
    '存在的问题及改进措施等内容）'];
Sheet1.Range('A12').Value = '签字 :                      年     月     日';
Sheet1.Range('A13').Value = '教研室审阅意见：';
Sheet1.Range('A14').Value = '教研室主任（签字）:             年    月    日';
Sheet1.Range('D16').Value = '主管院长签字：                  年    月    日';

% 设置字号
Sheet1.Range('A4:H12').Font.size = 10.5;    % 设置单元格A4至H12的字号为10.5
Sheet1.Range('A1').Font.size = 16;          % 设置单元格A1的字号为16
Sheet1.Range('A1').Font.bold = 2;           % 单元格A1的字体加粗

% 插入图片，如果当前工作表中有图形存在，通过循环将图形全部删除
Shapes = Sheet1.Shapes;    % 返回第1个工作表的Shapes接口的句柄
if Shapes.Count ~= 0;
    for i = 1 : Shapes.Count;
        Shapes.Item(1).Delete;    % 删除第1个Shape对象
    end;
end;

% 产生均值为75，标准差为4的正态分布随机数，画直方图，并设置图形属性
zft = figure('units','normalized','position',...
 [0.280469 0.553385 0.428906 0.251302],'visible','off');  % 新建图形窗口，设为不可见
set(gca,'position',[0.1 0.2 0.85 0.75]);    % 设置坐标系的位置和大小
data = normrnd(75,4,1000,1);    % 产生均值为75，标准差为4的正态分布随机数
hist(data);    % 绘制正态分布随机数的频数直方图
grid on;       % 添加参考网格
xlabel('考试成绩');    % 为X轴加标签
ylabel('人数');       % 为Y轴加标签
hgexport(zft, '-clipboard');    % 将直方图复制到剪贴板
% 选中工作表Sheet1的A11单元格，插入由MATLAB命令作出的直方图
Sheet1.Range('A11').Select;
Sheet1.Paste    % Sheet1.PasteSpecial;

delete(zft);    % 删除图形句柄
Workbook.Save   % 保存文档