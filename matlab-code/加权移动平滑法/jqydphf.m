%  jqydphf.m
clear,clc
y=[6.35 6.20 6.22 6.66 7.15 7.89 8.72 8.94 9.28 9.8];   %样本数据
w=[1/6;2/6;3/6];   % 合理选取权数
m=length(y);
n=3; 
for i=1:m-n+1 
    yhat(i)=y(i:i+n-1)*w; 
end 
yhat;   %各年的预测值
err=abs(y(n+1:m)-yhat(1:end-1))./y(n+1:m)   %各年的预测值与实际值的相对误差
T_err=1-sum(yhat(1:end-1))/sum(y(n+1:m))   %  样本数据的总相对误差
y_zhong=yhat(end)/(1-T_err)     %  样本数据的最终预测值