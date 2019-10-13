%--------------------------------------------------------------------------
%               创建一个Microsoft Excel服务器，插入外部图片
%--------------------------------------------------------------------------

% 创建一个Microsoft Excel服务器，返回句柄Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % 设置服务器为可见状态
Workbook = Excel.Workbooks.Add;    % 新建一个工作簿，返回其句柄
PicturePath = which('peppers.png');    % 返回图片文件peppers.png的完整路径
% 在当前工作表的指定位置处插入一幅指定大小的图片，返回句柄h1
h1 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,50,60,400,300);
% 在当前工作表的指定位置处插入一幅指定大小的图片，返回句柄h2
h2 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,500,60,200,150);
% 在当前工作表的指定位置处插入一幅指定大小的图片，返回句柄h3
h3 = Excel.ActiveSheet.Shapes.AddPicture(PicturePath,0,1,650,180,200,150);