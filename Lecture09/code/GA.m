%% 实现遗传算法
tic
clc,clear 
load data1.txt       %加载敌方 100 个目标的数据 
x=data1(:,1:2:8);x=x(:);   % 经度
y=data1(:,2:2:8);y=y(:);   % 维度
data1=[x y]; 
d1=[70,40]; 
data0=[d1;data1;d1]; 
%距离矩阵 d data0
data1=data0*pi/180; 
d=zeros(102); 
for i=1:101 
    for j=i+1:102 
        temp=cos(data1(i,1)-data1(j,1))*cos(data1(i,2))*cos(data1(j,2))+sin(data1(i,2))*sin(data1(j,2)); 
        d(i,j)=6370*acos(temp); 
    end 
end 
d=d+d';L=102;w=50;dai=100; 
%通过改良圈算法选取优良父代 A 
for k=1:w 
    c=randperm(100); 
    c1=[1,c+1,102]; 
    flag=1; 
 while flag>0 
      flag=0; 
   for m=1:L-3 
      for n=m+2:L-1 
        if d(c1(m),c1(n))+d(c1(m+1),c1(n+1))<d(c1(m),c1(m+1))+d(c1(n),c1(n+1)) 
           flag=1; 
           c1(m+1:n)=c1(n:-1:m+1); 
        end 
      end 
   end 
 end 
  J(k,c1)=1:102; 
end 
J=J/102;  
J(:,1)=0;J(:,102)=1; 
rng('default'); 
%遗传算法实现过程 
A=J; 
for k=1:dai  %产生 0～1间随机数列进行编码 
    B=A; 
    c=randperm(w); 
%交配产生子代 B 
    for i=1:2:w   
        F=2+floor(100*rand(1)); 
        temp=B(c(i),F:102); 
        B(c(i),F:102)=B(c(i+1),F:102); 
        B(c(i+1),F:102)=temp; 
    end 
%变异产生子代 C 
by=find(rand(1,w)<0.1); 
if length(by)==0 
    by=floor(w*rand(1))+1; 
end 
C=A(by,:); 
L3=length(by); 
for j=1:L3 
   bw=2+floor(100*rand(1,3)); 
   bw=sort(bw); 
   C(j,:)=C(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:102]); 
end 
   G=[A;B;C]; 
   TL=size(G,1); 
   %在父代和子代中选择优良品种作为新的父代 
   [dd,IX]=sort(G,2);temp(1:TL)=0; 
   for j=1:TL 
       for i=1:101 
           temp(j)=temp(j)+d(IX(j,i),IX(j,i+1)); 
       end 
   end 
     [DZ,IZ]=sort(temp); 
     A=G(IZ(1:w),:); 
end 
path=IX(IZ(1),:) 
long=DZ(1) 
toc 
xx=data0(path,1);yy=data0(path,2); 
plot(xx,yy,'-o') 