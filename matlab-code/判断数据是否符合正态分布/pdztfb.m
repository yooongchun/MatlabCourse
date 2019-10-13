%  pdztfb.m
% 判断评价结果数据是否符合正态分布
clc
load clhsjfile
r1=sum(red1,2)';
% 通过 normplot 函数判断四个打分值是否符合正态分布
normplot(r1)
title('此表格的主题 ')
