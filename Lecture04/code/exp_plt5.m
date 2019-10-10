x=10:2:22;
y=[950 640 460 340 250 180 140];
err=[30 20 18 34 21 32 12];
errorbar(x,y,err);
xlabel('Distance(cm)');
ylabel('Intensity(lux)');
