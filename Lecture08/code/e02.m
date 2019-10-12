x=-5:0.2:5;
y=3*x+2*x.^2-x.^3+2;
figure,plot(x,y,'-.b+','linewidth',2);hold on;

x0=2.3;
y0=3*x0+2*x0.^2-x0.^3+2;
tic
yl=Newton(x,y,2.3);
toc
fprintf('理论值：%.4f，实际值%.4f\n',y0,yl);
plot(x0,y0,'r*','markersize',12);hold off;