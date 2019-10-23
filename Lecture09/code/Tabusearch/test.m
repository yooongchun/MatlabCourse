clc
clear
%每个候选站址的建站代价（权值）
C=[5,4,5,6,3,6,4,5,4,6,4,5,4,6,5];
%候选站址的坐标
QQ=[2,6;3,5;4,5;3.7,2;4,2.5;5,2.6;7,5;7.7,5.2;...
    8,4;11,2;11.7,2.7;12.3,1.7;12,8;12.3,7;13,6];
%坐标加权值，得出候选站址集
CS=[QQ C'];
%初始解为5个点，元素表示站点在CS中的位置（行号）                  
Z=[2,3,8,12,15];% Z=[1,4,7,10,14];
%调用MScre生成移动台分布集MS
[MS]=MScre(CS);
%设置搜索次数为NT
NT=50;
%设置禁忌长度为TL
TL=5;
%调用Tabusearch函数
[MINL,MINZ,RESULT,best_so_far]=Tabusearch(CS,MS,Z,NT,TL);
%调用Disfigure函数生成图像
Disfigure(best_so_far,RESULT,CS,MINZ,NT,MINL);


