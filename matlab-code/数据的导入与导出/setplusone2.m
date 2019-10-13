function [DataRange, customdata] = setplusone2(DataRange)
for k = 1:DataRange.Count
   DataRange.Value{k} = DataRange.Value{k}+1;    % 将单元格取值加1
   customdata(k) = DataRange.Value{k};    % 把单元格取值赋给变量customdata
end
% 按照所选区域中单元格行数和列数把向量customdata变为矩阵
customdata = reshape(customdata, DataRange.Rows.Count, DataRange.Columns.Count);