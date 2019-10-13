%  qsydphf.m
clc,clear 
load y.txt   %把原始数据保存在纯文本文件 y.txt中 
m1=length(y);    
n=6;   %n为移动平均的项数 
for i=1:m1-n+1 
    yhat1(i)=sum(y(i:i+n-1))/n; 
end 
yhat1 
m2=length(yhat1); 
for i=1:m2-n+1 
    yhat2(i)=sum(yhat1(i:i+n-1))/n; 
end 
yhat2   
plot(1:21,y,'*') 
a21=2*yhat1(end)-yhat2(end) 
b21=2*(yhat1(end)-yhat2(end))/(n-1) 
y1986=a21+b21 
y1987=a21+2*b21