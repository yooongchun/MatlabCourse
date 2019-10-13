%初始化种群
%采用二进制Gray编码,其目的是为了克服二进制编码的Hamming悬崖缺点
function [initpop]=InitPopGray(popsize,bits)
len=sum(bits);
initpop=zeros(popsize,len);%The whole zero encoding individual
for i=2:popsize-1
    pop=round(rand(1,len));
    pop=mod(([0 pop]+[pop 0]),2);
    %i=1时,b(1)=a(1);i>1时,b(i)=mod(a(i-1)+a(i),2)
    %其中原二进制串:a(1)a(2)...a(n),Gray串:b(1)b(2)...b(n)
    initpop(i,:)=pop(1:end-1);
end
initpop(popsize,:)=ones(1,len);%The whole one encoding individual