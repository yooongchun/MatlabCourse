x = 0:0.2:10;
y1 = x.^2;
y2 = x.^3;
y3=x.^4;
y4=x;
subplot(2,2,1)
plot(x,y1)
subplot(2,2,2);
plot(x,y2)
subplot(2,2,3);
plot(x,y3);
subplot(2,2,4);
plot(x,y4);
