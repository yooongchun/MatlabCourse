function  p = SheepAndCar(n)
%   p = SheepAndCar(n)，利用蒙特卡洛方法求解蒙提霍尔问题，求参赛者更换选择之后
%   赢得汽车的概率p. 这里的n是正整数标量或向量，表示随机抽样的次数。
%   
%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2010/2/20 20:51:00 $
   
for i = 1:length(n)
    x = randsample(3,n(i),'true');  % 随机抽样
    p(i) = sum(x~=3)/n(i);  % 概率的模拟值
end