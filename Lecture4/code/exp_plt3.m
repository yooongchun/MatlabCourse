x=10:0.1:22;
y=95450./x.^2;
x2=10:2:22;
y2=[950 640 460 340 250 180 140];
plot(x,y,'-','linewidth',1)
xlabel('Distance(cm)')
ylabel('Intensity(lux)')
title('','fontsize',14);
axis([8 24 0 1200]);
text(14,700,'Comparison between theory and experiment.','edgecolor','r','linewidth',2);

hold on
plot(x2,y2,'ro--','linewidth',1,'markersize',10);
legend('Theory','Experiment');
hold off;
