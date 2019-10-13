%--------------------------------------------------------------------------
%               创建一个Microsoft Excel服务器，生成图1-12
%--------------------------------------------------------------------------

% 创建一个Microsoft Excel服务器，返回句柄Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % 设置服务器为可见状态
Workbook = Excel.Workbooks.Add;    % 新建一个工作簿，返回其句柄
Sheet1 = Workbook.Sheets.Item(1);    % 返回第1个工作表的句柄Sheet1
% 定义元胞数组Tabhead
Tabhead = {'样式','LineStyle','Weight','样式','LineStyle','Weight'};
Sheet1.Range('A1:F1').Value = Tabhead;    % 在单元格A1至F1中输入文字内容
Sheet1.Range('A2').Value = '无';    % 在单元格A2中输入文字内容
% 通过循环生成图1-12
for j = 1:3:4
    for i=2:8
        Sheet1.Cells.Item((i-1)*256+j).Borders.Item(4).Linestyle = i-2+7*(j-1)/3;
        Weight = Sheet1.Cells.Item((i-1)*256 + j).Borders.Item(4).Weight;
        Sheet1.Cells.Item((i-1)*256+j).Borders.Item(4).ColorIndex = 1;
        Sheet1.Cells.Item((i-1)*256+j+1).Value = i-2+7*(j-1)/3;
        Sheet1.Cells.Item((i-1)*256+j+1).HorizontalAlignment = 2;     
        Sheet1.Cells.Item((i-1)*256+j+2).Value = Weight;
        Sheet1.Cells.Item((i-1)*256+j+2).HorizontalAlignment = 2;
    end
end