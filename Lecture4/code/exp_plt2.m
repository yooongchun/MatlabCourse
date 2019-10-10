x=-2:0.01:4;
y=3*x.^3-26*x+6;
y2=9*x.^2-25;
y3=17*x;

plot(x,y,'-b');
hold on;
plot(x,y2,'--g');
plot(x,y3,'-.r');
hold off;