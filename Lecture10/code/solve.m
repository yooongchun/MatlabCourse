clear global;clc
syms r t0 xm x0;
xt=dsolve('Dx=r*(1-x/xm)*x','x(t0)=x0','t');
disp(xt);