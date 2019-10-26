% RK方法求解
[x,y]=ode45('doty',[0,0.5],1);
figure,
plot(x,y,'r--*');title('ODE45')
figure,
[x,y]=ode23('doty',[0,0.5],1);
plot(x,y,'b-+');title('ODE23')
figure,
[x,y]=ode113('doty',[0,0.5],1);
plot(x,y,'g-.o');title('ODE113')