x0=[0 3 5 7 9 11 12 13 14 15];
y0=[0 1.2 1.7 2.0 2.1 2.0 1.8 1.2 1.0 1.6];
x=0:0.1:15;
y1=Language(x0,y0,x); %调用前面编写的Lagrange插值函数
y2=interp1(x0,y0,x);
y3=interp1(x0,y0,x,'spline');
pp1=csape(x0,y0); y4=ppval(pp1,x);
pp2=csape(x0,y0,'second'); y5=ppval(pp2,x);
fprintf('比较一下不同插值方法和边界条件的结果:\n')
fprintf('x y1 y2 y3 y4 y5\n')
xianshi=[x',y1',y2',y3',y4',y5'];
fprintf('%f\t%f\t%f\t%f\t%f\t%f\n',xianshi')
subplot(2,2,1), plot(x0,y0,'+',x,y1), title('Lagrange')
subplot(2,2,2), plot(x0,y0,'+',x,y2), title('Piecewise linear')
subplot(2,2,3), plot(x0,y0,'+',x,y3), title('Spline1')
subplot(2,2,4), plot(x0,y0,'+',x,y4), title('Spline2')
dyx0=ppval(fnder(pp1),x0(1)) %求x=0处的导数
ytemp=y3(131:151);
index=find(ytemp==min(ytemp));
xymin=[x(130+index),ytemp(index)]

%% 结果分析
%可以看出，拉格朗日插值的结果根本不能应用，分段线性插值的光滑性较差（特别
%是在 14 = x 附近弯曲处），建议选用三次样条插值的结果。