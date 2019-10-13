function ceshi_Word
%利用MATLAB生成Word文档
%   ceshi_Word
%
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/14 12:37:00 $

% 设定测试Word文件名和路径
filespec_user = [pwd '\测试.doc'];

% 判断Word是否已经打开，若已打开，就在打开的Word中进行操作，否则就打开Word
try
    % 若Word服务器已经打开，返回其句柄Word
    Word = actxGetRunningServer('Word.Application');
catch
    % 创建一个Microsoft Word服务器，返回句柄Word
    Word = actxserver('Word.Application'); 
end;

% 设置Word属性为可见
Word.Visible = 1;    % 或set(Word, 'Visible', 1);

% 若测试文件存在，打开该测试文件，否则，新建一个文件，并保存，文件名为测试.doc
if exist(filespec_user,'file'); 
    Document = Word.Documents.Open(filespec_user);     
    % Document = invoke(Word.Documents,'Open',filespec_user);
else
    Document = Word.Documents.Add;     
    % Document = invoke(Word.Documents, 'Add'); 
    Document.SaveAs(filespec_user);
end

Content = Document.Content;    % 返回Content接口句柄
Selection = Word.Selection;    % 返回Selection接口句柄
Paragraphformat = Selection.ParagraphFormat;  % 返回ParagraphFormat接口句柄

% 页面设置
Document.PageSetup.TopMargin = 60;      % 上边距60磅
Document.PageSetup.BottomMargin = 45;   % 下边距45磅
Document.PageSetup.LeftMargin = 45;     % 左边距45磅
Document.PageSetup.RightMargin = 45;    % 右边距45磅

% 设定文档内容的起始位置和标题
Content.Start = 0;         % 设置文档内容的起始位置
title = '试  卷  分  析';
Content.Text = title;      % 输入文字内容
Content.Font.Size = 16 ;   % 设置字号为16
Content.Font.Bold = 4 ;    % 字体加粗
Content.Paragraphs.Alignment = 'wdAlignParagraphCenter';    % 居中对齐

Selection.Start = Content.end;    % 设定下面内容的起始位置
Selection.TypeParagraph;    % 回车，另起一段

xueqi = '（ 2009  —  2010   学年 第一学期）';
Selection.Text = xueqi;     % 在当前位置输入文字内容
Selection.Font.Size = 12;   % 设置字号为12
Selection.Font.Bold = 0;    % 字体不加粗
Selection.MoveDown;         % 光标下移（取消选中）
paragraphformat.Alignment = 'wdAlignParagraphCenter';    % 居中对齐
Selection.TypeParagraph;    % 回车，另起一段
Selection.TypeParagraph;    % 回车，另起一段
Selection.Font.Size = 10.5; % 设置字号为10.5

% 在光标所在位置插入一个12行9列的表格
Tables = Document.Tables.Add(Selection.Range,12,9);    

% 返回第1个表格的句柄
DTI = Document.Tables.Item(1);    % 或DTI = Tables;

% 设置表格边框
DTI.Borders.OutsideLineStyle = 'wdLineStyleSingle';
DTI.Borders.OutsideLineWidth = 'wdLineWidth150pt';
DTI.Borders.InsideLineStyle = 'wdLineStyleSingle';
DTI.Borders.InsideLineWidth = 'wdLineWidth150pt';
DTI.Rows.Alignment = 'wdAlignRowCenter';
DTI.Rows.Item(8).Borders.Item(1).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(8).Borders.Item(3).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(11).Borders.Item(1).LineStyle = 'wdLineStyleNone';
DTI.Rows.Item(11).Borders.Item(3).LineStyle = 'wdLineStyleNone';

% 设置表格列宽和行高
column_width = [53.7736,85.1434,53.7736,35.0094,...
    35.0094,76.6981,55.1887,52.9245,54.9057];    % 定义列宽向量
row_height = [28.5849,28.5849,28.5849,28.5849,25.4717,25.4717,...
    32.8302,312.1698,17.8302,49.2453,14.1509,18.6792];    % 定义行高向量
% 通过循环设置表格每列的列宽
for i = 1:9
    DTI.Columns.Item(i).Width = column_width(i);
end
% 通过循环设置表格每行的行高
for i = 1:12
    DTI.Rows.Item(i).Height = row_height(i);
end

% 通过循环设置每个单元格的垂直对齐方式
for i = 1:12
    for j = 1:9
        DTI.Cell(i,j).VerticalAlignment = 'wdCellAlignVerticalCenter';
    end
end

% 合并单元格
DTI.Cell(1, 4).Merge(DTI.Cell(1, 5));
DTI.Cell(2, 4).Merge(DTI.Cell(2, 5));
DTI.Cell(3, 4).Merge(DTI.Cell(3, 5));
DTI.Cell(4, 4).Merge(DTI.Cell(4, 5));
DTI.Cell(5, 2).Merge(DTI.Cell(5, 5));
DTI.Cell(5, 3).Merge(DTI.Cell(5, 6));
DTI.Cell(6, 2).Merge(DTI.Cell(6, 5));
DTI.Cell(6, 3).Merge(DTI.Cell(6, 6));
DTI.Cell(5, 1).Merge(DTI.Cell(6, 1));
DTI.Cell(7, 1).Merge(DTI.Cell(7, 9));
DTI.Cell(8, 1).Merge(DTI.Cell(8, 9));
DTI.Cell(9, 1).Merge(DTI.Cell(9, 3));
DTI.Cell(9, 2).Merge(DTI.Cell(9, 3));
DTI.Cell(9, 3).Merge(DTI.Cell(9, 4));
DTI.Cell(9, 4).Merge(DTI.Cell(9, 5));
DTI.Cell(10, 1).Merge(DTI.Cell(10, 9));
DTI.Cell(11, 5).Merge(DTI.Cell(11, 9));
DTI.Cell(12, 5).Merge(DTI.Cell(12, 9));
DTI.Cell(11, 1).Merge(DTI.Cell(12, 4));

Selection.Start = Content.end;    % 设置光标位置在文档内容的结尾
Selection.TypeParagraph;          % 回车，另起一段
Selection.Text = '主管院长签字：            年    月    日';    % 输入文字内容
Paragraphformat.Alignment = 'wdAlignParagraphRight';    % 右对齐
Selection.MoveDown;    % 光标下移

% 写入表格内容
DTI.Cell(1,1).Range.Text = '课程名称';
DTI.Cell(1,3).Range.Text = '课程号';
DTI.Cell(1,5).Range.Text = '任课教师学院';
DTI.Cell(1,7).Range.Text = '任课教师';
DTI.Cell(2,1).Range.Text = '授课班级';
DTI.Cell(2,3).Range.Text = '考试日期';
DTI.Cell(2,5).Range.Text = '应考人数';
DTI.Cell(2,7).Range.Text = '实考人数';
DTI.Cell(3,1).Range.Text = '出卷方式';
DTI.Cell(3,3).Range.Text = '阅卷方式';
DTI.Cell(3,5).Range.Text = '选用试卷A/B';
DTI.Cell(3,7).Range.Text = '考试时间';
DTI.Cell(4,1).Range.Text = '考试方式';
DTI.Cell(4,3).Range.Text = '平均分';
DTI.Cell(4,5).Range.Text = '不及格人数';
DTI.Cell(4,7).Range.Text = '及格率';
DTI.Cell(5,1).Range.Text = '成绩分布';
DTI.Cell(5,2).Range.Text = '90分以上      人占        %';
DTI.Cell(5,3).Range.Text = '80---89分        人占        %';
DTI.Cell(6,2).Range.Text = '70--79分      人占        %';
DTI.Cell(6,3).Range.Text = '60---69分        人占        %';
DTI.Cell(7,1).Range.Text = ['试卷分析（含是否符合教学大纲、难度、知识覆'...
    '盖面、班级分数分布分析、学生答题存在的共性问题与知识掌握情况、教学中'...
    '存在的问题及改进措施等内容）'];
DTI.Cell(7,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(9,2).Range.Text = '签字 :';
DTI.Cell(9,4).Range.Text = '年    月    日';
DTI.Cell(10,1).Range.Text = '教研室审阅意见：';
DTI.Cell(10,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(10,1).VerticalAlignment = 'wdCellAlignVerticalTop';
DTI.Cell(11,2).Range.Text = '教研室主任（签字）:          年    月    日';
DTI.Cell(11,2).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(8,1).Range.ParagraphFormat.Alignment = 'wdAlignParagraphLeft';
DTI.Cell(8,1).VerticalAlignment = 'wdCellAlignVerticalTop';
DTI.Cell(9,2).Borders.Item(2).LineStyle = 'wdLineStyleNone';
DTI.Cell(9,2).Borders.Item(4).LineStyle = 'wdLineStyleNone';
DTI.Cell(9,3).Borders.Item(4).LineStyle = 'wdLineStyleNone';
DTI.Cell(11,1).Borders.Item(4).LineStyle = 'wdLineStyleNone';

% 如果当前工作文档中有图形存在，通过循环将图形全部删除
Shape = Document.Shapes;    % 返回Shapes接口的句柄
ShapeCount = Shape.Count;   % 返回文档中Shape对象的个数
if ShapeCount ~= 0;
    for i = 1:ShapeCount;
        Shape.Item(1).Delete;    % 删除第1个Shape对象
    end;
end;

% 产生标准正态分布随机数，画直方图，并设置图形属性
zft = figure('units','normalized','position',...
 [0.280469 0.553385 0.428906 0.251302],'visible','off');  % 新建图形窗口，设为不可见
set(gca,'position',[0.1 0.2 0.85 0.75]);    % 设置坐标系的位置和大小
data = normrnd(0,1,1000,1);    % 产生标准正态分布随机数
hist(data);    % 绘制标准正态分布随机数的频数直方图
grid on;       % 添加参考网格
xlabel('考试成绩');    % 为X轴加标签
ylabel('人数');       % 为Y轴加标签

% 将图形复制到粘贴板
hgexport(zft, '-clipboard');

% 将图形粘贴到当前文档里（表格的第8行第1列的单元格里），并设置图形版式为浮于文字上方
% Selection.Range.PasteSpecial;
DTI.Cell(8,1).Range.Paragraphs.Item(1).Range.PasteSpecial;
Shape.Item(1).WrapFormat.Type = 3;
Shape.Item(1).ZOrder('msoBringInFrontOfText');   % 设置图片叠放次序为浮于文字上方
delete(zft);    % 删除图形句柄

Document.ActiveWindow.ActivePane.View.Type = 'wdPrintView';    % 设置视图方式为页面
Document.Save;     % 保存文档
