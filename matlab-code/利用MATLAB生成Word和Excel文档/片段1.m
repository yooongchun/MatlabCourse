%--------------------------------------------------------------------------
%           创建一个Microsoft Excel服务器，改变单元格A1的边框颜色
%--------------------------------------------------------------------------

% 创建一个Microsoft Excel服务器，返回句柄Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % 设置服务器为可见状态
Workbook = Excel.Workbooks.Add;    % 新建一个工作簿，返回其句柄
Sheet1 = Workbook.Sheets.Item(1);    % 返回第1个工作表的句柄Sheet1

% 通过循环改变单元格A1的边框颜色
for i = 0:56
    Sheet1.Range('A1').Borders.ColorIndex = i;
    pause(1);
end