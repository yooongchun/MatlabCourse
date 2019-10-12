x0=[58.2,52.6 56.2,41.2  65.3,60.8
    49.1,42.8  54.1,50.5  51.6,48.4
    60.1,58.3  70.9,73.2  39.2,40.7
    75.8,71.5  58.2,51.0  48.7,41.4];

x1=x0(:,1:2:5);
x2=x0(:,2:2:6);
x=zeros(8,3);
for i=1:4
    x(2*i-1,:)=x1(i,:);
    x(2*i,:)=x2(i,:);
end
[p,t,st]=anova2(x,2);
alpha=0.05;
if sum(p>alpha)>2
    fprintf('with p=%.4f,%.4f,%.4f,we can accept H0\n',p);
else
    fprintf('with p=%.4f,%.4f,%.4f,we can not accept H0\n',p);
end