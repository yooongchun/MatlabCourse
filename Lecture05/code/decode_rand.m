function message=decode_rand(coded_msg,coding_num,lower_limit,upper_limit)
    % 该程序进行解密操作
    % 输入参数：coded_msg表示已加密的密文，coding_num表示随机数生成器使用的种子，lower_limit和upper_limit表示数值上下限
    %返回值是解密的密文

    converted_array=coded_msg';
    difference = upper_limit - lower_limit;
    rng(coding_num);
    rand_num = lower_limit + difference*rand(size(coded_msg'));
    new_array=converted_array-rand_num;
    
    associated_array=new_array.^(1/pi);
    associated_array=round(associated_array);
    message=char(associated_array);
end