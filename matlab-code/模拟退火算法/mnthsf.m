clc,clear 
load sj.txt    %加载敌方100 个目标的数据， 数据按照表格中的位置保存在纯文本文件 sj.txt 中 
x=sj(:,1:2:8);x=x(:); 
y=sj(:,2:2:8);y=y(:); 
sj=[x y]; 
d1=[70,40]; 
sj=[d1;sj;d1]; 
sj=sj*pi/180; 
%距离矩阵 d 
d=zeros(102); 
for i=1:101 
    for j=i+1:102 
        temp=cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2)); 
        d(i,j)=6370*acos(temp); 
    end 
end 
d=d+d'; 
S0=[];Sum=inf; 
rand('state',sum(clock)); 
for j=1:1000 
    S=[1 1+randperm(100),102]; 
    temp=0;
    for i=1:101 
        temp=temp+d(S(i),S(i+1)); 
    end 
    if temp<Sum 
        S0=S;Sum=temp; 
    end 
end 
e=0.1^30;L=20000;at=0.999;T=1; 
%退火过程 
for k=1:L 
   %产生新解 
c=2+floor(100*rand(1,2)); 
c=sort(c); 
c1=c(1);c2=c(2); 
  %计算代价函数值 
  df=d(S0(c1-1),S0(c2))+d(S0(c1),S0(c2+1))-d(S0(c1-1),S0(c1))-d(S0(c2),S0(c2+1)); 
   %接受准则 
  if df<0 
  S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:102)];       
  Sum=Sum+df; 
  elseif exp(-df/T)>rand(1) 
  S0=[S0(1:c1-1),S0(c2:-1:c1),S0(c2+1:102)]; 
  Sum=Sum+df; 
  end 
  T=T*at; 
   if T<e 
       break; 
   end 
end 
 %  输出巡航路径及路径长度 
S0
Sum