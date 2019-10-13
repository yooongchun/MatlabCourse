function  [E0,Em] = GameMont2(n)
% 摸球游戏揭秘
%   [E0,Em] = GameMont2(n)，求摸球者在一次摸球游戏中得到的奖金（罚金）的数学期
%   望（均值）的理论值E0和蒙特卡洛模拟值Em. 输入参数n为游戏的次数，它是一个正整
%   数标量或向量.

a = nchoosek(16,8);  % 组合数（16选8）
p = 0;
% 通过循环计算每种可能结果的理论概率
for i = 4:8
    p(i-3) = 2^(i~=4)*nchoosek(8,i)*nchoosek(8,8-i)/a;
end
Award = [-3, 0.2, 0.5, 1, 10];  % 定义奖金（罚金）向量
E0 = p*Award';  % 数学期望的理论值

x = 0;
pm = 0;
Em = 0;
% 通过循环计算期望的模拟值
 for i=1:length(n)
     x = randsample(Award,n(i),'true',p);  % 有放回随机抽样
     pm = tabulate(x);  % 计算 x 对应的频数频率表
     Em(i) = pm(:,1)'*pm(:,end)/100;  % 计算模拟值
 end