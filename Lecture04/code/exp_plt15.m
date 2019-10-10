x=-3:0.25:3;
y=-3:0.25:3;
Z=1.8.^(-1.5*sqrt(X.^2+Y.^2)).*cos(0.5*Y).*sin(X);

figure, contour(X, Y, Z, 0.1:0.1:1.9);
axis square;
xlabel('x', 'Fontsize',14);
ylabel('y', 'Fontsize',14);
title('Plotted by function contour', 'Fontsize',14);

figure, contourf(X, Y, Z, 0.1:0.1:1.9);
axis square;
xlabel('x', 'Fontsize',14);
ylabel('y', 'Fontsize',14);
title('Plotted by function contourf', 'Fontsize',14);