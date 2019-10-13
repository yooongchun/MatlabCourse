function [err]=h(sol) %构造目标函数
t=1:14;
L=[1016.1 84.89 553.4 339.7 268.5 414.7 416.3 317.5 242.2 141.2 80.4 115.9 70.3 22.9];
[m,n]=size(L);
err=zeros(1,n);
A=sol(1);B=sol(2);
err=0;
for i=1:n
err=err+(L(i)-10.^(A+B*i)).^2;
end

