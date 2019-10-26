%% 求解对比
[x,y]=ode45('doty',[0,0.5],1);
figure
plot(x,y,'r--*');
hold on
[x,y]=ode23('doty',[0,0.5],1);
plot(x,y,'b-+');
[x,y]=ode113('doty',[0,0.5],1);
plot(x,y,'g-.o');

[x,y]=eulerpro('doty',0,0.5,1);
plot(x,y,'-->');
legend('ODE45','ODE23','ODE113','EULER-PRO');
grid on
xlabel('X')
ylabel('Y')