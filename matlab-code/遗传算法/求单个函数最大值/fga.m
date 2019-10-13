
function [BestPop,Trace]=fga(FUN,LB,UB,eranum,popsize,pCross,pMutation,pInversion,options)
% [BestPop,Trace]=fmaxga(FUN,LB,UB,eranum,popsize,pcross,pmutation)
% Finds a  maximum of a function of several variables.
% fmaxga solves problems of the form: 
%      max F(X)  subject to:  LB <= X <= UB                           
%  BestPop       - 最优的群体即为最优的染色体群
%  Trace         - 最佳染色体所对应的目标函数值
%  FUN           - 目标函数
%  LB            - 自变量下限
%  UB            - 自变量上限
%  eranum        - 种群的代数,取100--1000(默认200)
%  popsize       - 每一代种群的规模；此可取50--200(默认100)
%  pcross        - 交叉概率,一般取0.5--0.85之间较好(默认0.8)
%  pmutation     - 初始变异概率,一般取0.05-0.2之间较好(默认0.1)
%  pInversion    - 倒位概率,一般取0.05－0.3之间较好(默认0.2)
%  options       - 1*2矩阵,options(1)=0二进制编码(默认0),option(1)~=0十进制编
%码,option(2)设定求解精度(默认1e-4)
%
%  ------------------------------------------------------------------------

T1=clock;
if nargin<3, error('FMAXGA requires at least three input arguments'); end
if nargin==3, eranum=200;popsize=100;pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==4, popsize=100;pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==5, pCross=0.8;pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==6, pMutation=0.1;pInversion=0.15;options=[0 1e-4];end
if nargin==7, pInversion=0.15;options=[0 1e-4];end
if find((LB-UB)>0)
   error('数据输入错误,请重新输入(LB<UB):');
end
s=sprintf('程序运行需要约%.4f 秒钟时间,请稍等......',(eranum*popsize/1000));
disp(s);

global m n NewPop children1 children2 VarNum

bounds=[LB;UB]';bits=[];VarNum=size(bounds,1);
precision=options(2);%由求解精度确定二进制编码长度
bits=ceil(log2((bounds(:,2)-bounds(:,1))' ./ precision));%由设定精度划分区间
[Pop]=InitPopGray(popsize,bits);%初始化种群
[m,n]=size(Pop);
NewPop=zeros(m,n);
children1=zeros(1,n);
children2=zeros(1,n);
pm0=pMutation;
BestPop=zeros(eranum,n);%分配初始解空间BestPop,Trace
Trace=zeros(eranum,length(bits)+1);
i=1;
while i<=eranum
    for j=1:m
        value(j)=feval(FUN(1,:),(b2f(Pop(j,:),bounds,bits)));%计算适应度
    end
    [MaxValue,Index]=max(value);
    BestPop(i,:)=Pop(Index,:);
    Trace(i,1)=MaxValue;
    Trace(i,(2:length(bits)+1))=b2f(BestPop(i,:),bounds,bits);
    [selectpop]=NonlinearRankSelect(FUN,Pop,bounds,bits);%非线性排名选择
[CrossOverPop]=CrossOver(selectpop,pCross,round(unidrnd(eranum-i)/eranum));
%采用多点交叉和均匀交叉，且逐步增大均匀交叉的概率
    %round(unidrnd(eranum-i)/eranum)
    [MutationPop]=Mutation(CrossOverPop,pMutation,VarNum);%变异
    [InversionPop]=Inversion(MutationPop,pInversion);%倒位
    Pop=InversionPop;%更新
pMutation=pm0+(i^4)*(pCross/3-pm0)/(eranum^4);
%随着种群向前进化，逐步增大变异率至1/2交叉率
    p(i)=pMutation;
    i=i+1;
end
t=1:eranum;
plot(t,Trace(:,1)');
title('函数优化的遗传算法');xlabel('进化世代数(eranum)');ylabel('每一代最优适应度(maxfitness)');
[MaxFval,I]=max(Trace(:,1));
X=Trace(I,(2:length(bits)+1));
hold on;  plot(I,MaxFval,'*');
text(I+5,MaxFval,['FMAX=' num2str(MaxFval)]);
str1=sprintf('进化到 %d 代 ,自变量为 %s 时,得本次求解的最优值 %f\n对应染色体是：%s',I,num2str(X),MaxFval,num2str(BestPop(I,:)));
disp(str1);
%figure(2);plot(t,p);%绘制变异值增大过程
T2=clock;
elapsed_time=T2-T1;
if elapsed_time(6)<0
    elapsed_time(6)=elapsed_time(6)+60; elapsed_time(5)=elapsed_time(5)-1;
end
if elapsed_time(5)<0
    elapsed_time(5)=elapsed_time(5)+60;elapsed_time(4)=elapsed_time(4)-1;
end  %像这种程序当然不考虑运行上小时啦
str2=sprintf('程序运行耗时 %d 小时 %d 分钟 %.4f 秒',elapsed_time(4),elapsed_time(5),elapsed_time(6));
disp(str2);

 




 



 



 








 








