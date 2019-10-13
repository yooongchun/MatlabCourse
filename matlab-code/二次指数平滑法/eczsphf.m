%   eczsphf.m
clc,clear 
load yuanshi.txt   %原始数据以列向量的方式存放在纯文本文件中 
yt=fadian; 
n=length(yt); 
alpha=0.3; 
st1(1)=yt(1); 
st2(1)=yt(1); 
for i=2:n 
    st1(i)=alpha*yt(i)+(1-alpha)*st1(i-1); 
    st2(i)=alpha*st1(i)+(1-alpha)*st2(i-1); 
end 
xlswrite('yuanshi.xls',[st1',st2']) 
a=2*st1-st2 
b=alpha/(1-alpha)*(st1-st2) 
yhat=a+b; 
xlswrite('yuanshi.xls',yhat','Sheet1','C2') 
str=char(['C',int2str(n+2)]); 
xlswrite('yuanshi.xls',a(n)+2*b(n),'Sheet1',str) 