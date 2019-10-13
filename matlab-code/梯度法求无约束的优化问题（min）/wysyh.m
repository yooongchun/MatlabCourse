%  wysyh.m
%  求解无约束优化问题
clc 
x=[2;2]; 
[f0,g]=detaf(x); 
while norm(g)>0.000001 
   p=-g/norm(g); 
   t=1.0;f=detaf(x+t*p); 
   while f>f0 
      t=t/2; 
        f=detaf(x+t*p); 
   end 
x=x+t*p; 
[f0,g]=detaf(x); 
end 
x,f0 