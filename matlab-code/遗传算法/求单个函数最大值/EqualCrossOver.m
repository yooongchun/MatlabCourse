%采用均匀交叉
function [children1,children2]=EqualCrossOver(parent1,parent2)

global n children1 children2
hidecode=round(rand(1,n));%随机生成掩码
crossposition=find(hidecode==1);
holdposition=find(hidecode==0);
children1(crossposition)=parent1(crossposition);%掩码为1，父1为子1提供基因
children1(holdposition)=parent2(holdposition);%掩码为0，父2为子1提供基因
children2(crossposition)=parent2(crossposition);%掩码为1，父2为子2提供基因
children2(holdposition)=parent1(holdposition);%掩码为0，父1为子2提供基因