function [Coded_message,lower_limit,upper_limit] = encode_rand(original_message,coding_integer)
    % 该程序进行基础加密
    % 输入参数：original_message代表原文，coding_integer代表用来加密的随机数生成器种子
    %返回值：Coded_message表示加密的密文，lower_limit和upper_limit表示数值上下限

    % 字符转为数字
    associated_array 	= double(original_message);
    %进行pi次幂运算
    new_array        	= associated_array.^(pi);
    %求最小最大值
    min_new_array    	= min(min(new_array));
    max_new_array	= max(max(new_array));
    %计算上限下限和差值
    lower_limit      	= round(min_new_array);
    upper_limit      	= round(max_new_array);
    difference        	= upper_limit - lower_limit;
    %使用随机数生成器生成随机数
    rng(coding_integer)
    random_numbers	= lower_limit + difference*rand(size(original_message));
    %添加随机数
    converted_array  	= new_array + random_numbers;
    %获得加密密文
    Coded_message  	= converted_array';
end