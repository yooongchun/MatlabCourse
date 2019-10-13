%--------------------------------------------------------------------------
%                   创建一个日历控件，保存其状态并加载
%--------------------------------------------------------------------------

cal = actxcontrol('mscal.calendar',[10 10 540 400]);  % 创建日历控件，返回句柄cal
cal.save('mscal.mat');    % 将日历控件cal保存到文件mscal.mat

cal.month = 1;   % 设置cal的month属性的属性值为1
cal.day = 1;    % 设置cal的day属性的属性值为1
cal.year = 2000;    % 设置cal的year属性的属性值为2000
cal.get    % 查看修改后cal的属性

cal.load('mscal.mat');    % 重新加载cal的初始状态
cal.get
