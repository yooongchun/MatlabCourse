clear
bound=[0 -1;4 0];
[m,n]=size(bound);
D=bound(1,1:n);
U=bound(2,1:n);
for i=1:n
x1(i)=D(i)+rand*(U(i)-D(i));
end
x1
N=1;
T=1000;
T0=0.001;
k=250;
a=0.965;
step=0.001;
T1=clock;
s=sprintf('程序运行正在进行 ,请稍等 ……');
disp(s);
while T>T0
for t=1:k
f1=h(x1);
for i=1:n
x2(i)=x1(i)+step*(rand-0.5);
while x2(i)<D(i)|x2(i)>U(i)
x2(i)=x1(i)+step*(rand-0.5);
end
end
f2=h(x2);
if f2-f1<0
    x1=x2;
elseif exp((f1-f2)/T)>rand
x1=x2;
end
temp_x(t,1:n)=x1;
temp_y(t,1)=h(x1);
end
[ty,ti]=min(temp_y) ;
x1=temp_x(ti,1:n);
X(N,1:n)=x1;
Y(N)=h(x1);
N=N+1;
T=a*T;
end
T2=clock;
CostTime=T2-T1;
if CostTime(6)<0
CostTime(6)=CostTime(6)+60;
CostTime(5)=CostTime(5)-1;
end
if CostTime(5)<0
CostTime(5)=CostTime(5)+60;
CostTime(4)=CostTime(4)-1;
end
tt=1:N-1;
plot(tt,Y)
[fmin,I]=min(Y);
x=X(I,1:n)
fmin
str4=sprintf('程序运行耗时%d小时%d分钟%.4f秒',CostTime(4),CostTime(5),CostTime(6));
disp(str4);