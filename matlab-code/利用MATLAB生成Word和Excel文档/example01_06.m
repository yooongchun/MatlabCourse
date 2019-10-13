%--------------------------------------------------------------------------
%               创建一个Microsoft Word服务器，插入图片
%--------------------------------------------------------------------------

% 创建一个Microsoft Word服务器，返回句柄Word
Word = actxserver('Word.Application'); 

% 设置Word服务器为可见状态
set(Word, 'Visible', 1);     %或Word.Visible = 1;
Document = Word.Documents.Add;    % 新建一个空白文档
Selection = Word. Selection;    % 返回Word服务器的Selection接口的句柄


%********************************插入外部图片*******************************
filename = [matlabroot '\toolbox\images\imdemos\football.jpg'];  % 图片完整路径
% 在光标位置处插入一幅图片，版式为嵌入式
handle1 = Selection.InlineShapes.AddPicture(filename);
% 在指定位置处加入一幅图片，版式为浮于文字上方
handle2 = Document.Shapes.AddPicture(filename, [], [], 180, 50, 200, 170);


%********************************插入内部图片*******************************
Document = Word.Documents.Add;    % 新建一个空白文档
Selection = Word. Selection;    % 返回Word服务器的Selection接口的句柄
% 调用normrnd函数生成1000个服从标准正态分布的随机数
data = normrnd(0,1,1000,1);
% 新建一个图形窗口，设置为不可见状态
zft = figure('units','normalized','position',...
                [0.280469 0.553385 0.428906 0.251302],'visible','off');
% 设置坐标系的位置和大小
set(gca,'position',[0.1 0.2 0.85 0.75]);
hist(data);    % 绘制频数直方图
grid on;    % 添加参考网格
xlabel('考试成绩');    % 为X轴加标签
ylabel('人数');       % 为Y轴加标签
hgexport(zft, '-clipboard');    %将图形复制到剪贴板
Selection.Paste;    % 在当前光标位置处插入剪贴板上的图片，版式为嵌入式
Selection.TypeParagraph;    % 回车，另起一段
Selection.PasteSpecial;    % 在当前光标位置处插入剪贴板上的图片，版式为浮于文字上方