%% 求解常微分方程组
clc,clear
equ1='D2f+3*g=sin(x)';
equ2='Dg+Df=cos(x)';
[general_f,general_g]=dsolve(equ1,equ2,'x')
[f,g]=dsolve(equ1,equ2,'Df(2)=0,f(3)=3,g(5)=1','x')