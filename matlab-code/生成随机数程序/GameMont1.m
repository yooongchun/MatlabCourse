function  [Em,E0] = GameMont1(n)
% 摸球游戏揭秘
%   [Em,E0] = GameMont1(n)，求摸球者在一次摸球游戏中得到的奖金（罚金）的数学期
%   望（均值）的理论值E0和蒙特卡洛模拟值Em. 输入参数n为游戏的次数，它是一个正整数.

a = nchoosek(16,8);  % 组合数（16选8）
p = 0;
% 通过循环计算每种可能结果的理论概率
for i = 4:8
    p(i-3) = 2^(i~=4)*nchoosek(8,i)*nchoosek(8,8-i)/a;
end
E0 = p*[-3, 0.2, 0.5, 1, 10]';  % 数学期望的理论值
Freq0 = zeros(1,5);
% 做n次摸球游戏，计算各种可能的结果出现的频数
for i = 1:n
    x = randsample(16,8,'false');  % 不放回随机抽样
    x(x<=8) = 1;  % 将x中取值为1至8的元素改为1,用来标记红球
    x(x>8) = 2;   % 将x中取值为9至16的元素改为2,用来标记白球
    % 统计x中1和2出现的次数，整理成[4 4],[3 5],[2 6],[1 7],[0 8]的形式
    x = sort(x);    % 将x从小到大排序
    x1 = diff(x);    % 求差分
    x1(end + 1) = 1;  % 在x1的最后补上一个1
    x1 = find(x1);   % 查找x1中非零元素的下标
    x1 = [0; x1];   % 在x1的前面补上一个0
    Freq = sort(diff(x1));  % 对x1求差分，然后排序
    % 统计[4 4],[3 5],[2 6],[1 7],[0 8]各自出现的频数
    if Freq == 8
        Freq = [0; 8];
    end
    if isequal(Freq,[4; 4])
        Freq0 = Freq0 + [1 0 0 0 0];  % 计算 4:4 出现的频数
    elseif isequal(Freq,[3; 5])
        Freq0 = Freq0 + [0 1 0 0 0];  % 计算 3:5 出现的频数
    elseif isequal(Freq,[2; 6])
        Freq0 = Freq0 + [0 0 1 0 0];  % 计算 2:6 出现的频数
    elseif isequal(Freq,[1; 7])
        Freq0 = Freq0 + [0 0 0 1 0];  % 计算 1:7 出现的频数
    else
        Freq0 = Freq0 + [0 0 0 0 1];  % 计算 0:8 出现的频数
    end
end
Em = Freq0*[-3, 0.2, 0.5, 1, 10]'/n;  % 计算数学期望的模拟值