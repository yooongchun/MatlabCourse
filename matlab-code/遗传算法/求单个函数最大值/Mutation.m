%变异操作
function [NewPop]=Mutation(OldPop,pMutation,VarNum)

global m n NewPop
r=rand(1,m);
position=find(r<=pMutation);
len=length(position);
if len>=1
   for i=1:len
       k=unidrnd(n,1,VarNum); %设置变异点数，一般设置1点
       for j=1:length(k)
           if OldPop(position(i),k(j))==1
              OldPop(position(i),k(j))=0;
           else
              OldPop(position(i),k(j))=1;
           end
       end
   end
end
NewPop=OldPop;