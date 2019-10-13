function result = HistRate(x)
%   HistRate(x)，统计数组 x 中的元素出现的频数、频率和累积频率，以表格形式显示在屏幕上.
%   x可以是数值型数组、字符串、字符型数组、字符串元胞数组和名义尺度数组。
%
%   result = HistRate(x)，返回矩阵或元胞数组result，它是多行4列的矩阵或元胞数组，
%   四列分别对应取值、频数、频率、累积频率。当x是数值型数组时，result为矩阵；当x
%   是字符串、字符型数组、字符串元胞数组和名义尺度数组时，result为元胞数组。
%
%   用户还可参考tabulate函数，该函数比tabulate函数的效率高。
%   
%   Copyright xiezhh，2010.3.8

if isnumeric(x)
    x = x(:);
    x = x(~isnan(x));
    xid = [];
else
    [x,xid] = grp2idx(x);
    x = x(~isnan(x));
end

x = sort(x(:));    % 排序
m = length(x);
x1 = diff(x);    % 求差分
x1(end + 1) = 1;
x1 = find(x1);
CumFreq = x1/m;
value = x(x1);
x1 = [0; x1];
Freq1 = diff(x1);
Freq2 = Freq1/m;
if  nargout == 0
    if isempty(xid)
        fmt1 = '%11s   %8s   %6s    %6s\n';
        fmt2 = '  %10d     %8d     %6.2f%%     %6.2f%%\n';
        fprintf(1, fmt1, '取值', '频数', '频率', '累积频率');
        fprintf(1, fmt2, [value'; Freq1'; 100*Freq2'; 100*CumFreq']);
    else
        head = {'取值', '频数', '频率(%)', '累积频率(%)'};
        [head;xid,num2cell([Freq1, 100*Freq2, 100*CumFreq])]
    end
else
    if isempty(xid)
        result = [value Freq1 Freq2 CumFreq];
    else
        result = [xid,num2cell([Freq1, Freq2, CumFreq])];
    end
end
