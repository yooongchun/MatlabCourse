%  ndfqjz.m
%  牛顿法求解无约束的最优化问题
clc,clear 
x=[2;2]; 
[f0,g1,g2]=nwfun(x); 
while norm(g1)>0.00001       
   p=-inv(g2)*g1;p=p/norm(p); 
   t=1.0;f=nwfun(x+t*p); 
   while f>f0 
      t=t/2;f=nwfun(x+t*p); 
   end 
x=x+t*p; 
[f0,g1,g2]=nwfun(x); 
end 
x,f0 