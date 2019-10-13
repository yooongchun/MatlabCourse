%--------------------------------------------------------------------------
%               创建一个Microsoft Excel服务器，生成图1-11
%--------------------------------------------------------------------------

% 创建一个Microsoft Excel服务器，返回句柄Excel
Excel = actxserver('Excel.Application');
Excel.Visible = 1;    % 设置服务器为可见状态
Workbook = Excel.Workbooks.Add;    % 新建一个工作簿，返回其句柄
Sheet1 = Workbook.Sheets.Item(1);    % 返回第1个工作表的句柄Sheet1
% 通过循环生成图1-11
for j=1:2:7
    for i=1:14
        Sheet1.Cells.Item((i-1)*256 + j).Interior.ColorIndex = i + 14*(j-1)/2;
        Sheet1.Cells.Item((i-1)*256 + j + 1).Value = i + 14*(j-1)/2;
        Sheet1.Cells.Item((i-1)*256 + j + 1).HorizontalAlignment = 2;
    end
end