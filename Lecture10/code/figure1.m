t=1961:1970;
y=3.06*10^9*exp(t-1961);
figure,
subplot(2,1,1)
plot(t,y,'b--*','linewidth',5);
xlabel('年份/年');
ylabel('人口/口');

subplot(2,1,2)
t=1961:2000;
y=3.06*10^9*exp(t-1961);
plot(t,y,'r-+','linewidth',5);
xlabel('年份/年');
ylabel('人口/口');