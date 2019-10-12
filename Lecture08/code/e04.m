x=-5:0.2:5;
y=3*x+5*x.^2-4*x.^3+2*x.^5+2;
figure,plot(x,y,'-.b+','linewidth',2);hold on;

x0=2.3;
y0=3*x0+2*x0.^2-x0.^3+2;
y01=3+4*x0-9*x0.^2-8*x0.^3;
tic
y1=Hermite(x,y,y01,x0);
toc
fprintf('理论值：%.4f，实际值%.4f\n',y0,yl);
plot(x0,y0,'r*','markersize',12);hold off;