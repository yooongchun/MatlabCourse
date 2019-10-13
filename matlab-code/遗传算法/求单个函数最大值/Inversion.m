%µ¹Î»²Ù×÷

function [NewPop]=Inversion(OldPop,pInversion)

global m n NewPop
NewPop=OldPop;
r=rand(1,m);
PopIn=find(r<=pInversion);
len=length(PopIn);
if len>=1
    for i=1:len
        d=sort(unidrnd(n,1,2));
        if d(1)~=1&d(2)~=n
           NewPop(PopIn(i),1:d(1)-1)=OldPop(PopIn(i),1:d(1)-1);
           NewPop(PopIn(i),d(1):d(2))=OldPop(PopIn(i),d(2):-1:d(1));
           NewPop(PopIn(i),d(2)+1:n)=OldPop(PopIn(i),d(2)+1:n);
       end
   end
end