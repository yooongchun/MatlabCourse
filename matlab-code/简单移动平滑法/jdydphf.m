%  jdydphf.m
clc,clear 
y=[533.8 574.6 606.9 649.8 705.1 772.0 816.4 892.7 963.9 1015.1 1102.7]; 
%  样本数据
m=length(y);   % 样本数据的长度 
n=[4,5];   %  n为移动平均的项数,可根据需要变动 
for i=1:length(n) 
    %由于 n的取值不同，yhat 的长度不一致，下面使用了细胞数组 
    for j=1:m-n(i)+1 
        yhat{i}(j)=sum(y(j:j+n(i)-1))/n(i);   
    end 
    y12(i)=yhat{i}(end);  % 最终预测值
    s(i)=sqrt(mean((y(n(i)+1:m)-yhat{i}(1:end-1)).^2));  % 最终方差值
end 
y12    %显示样本数据最终预测值
s      %显示样本数据最终方差值