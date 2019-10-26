%% 常微分防蹭解析解
y=dsolve('x^2+y+(x-2*y)*Dy=0','x');
disp(y);