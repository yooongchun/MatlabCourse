function [f,df]=detaf(x); 
f=x(1)^2+25*x(2)^2; 
df=[2*x(1) 
50*x(2)];