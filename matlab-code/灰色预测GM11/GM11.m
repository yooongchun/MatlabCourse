function [X,c,error1,error2]=GM11(X0,k)
format short;
n=length(X0);
X1=[];
X1(1)=X0(1);
for i=2:n
    X1(i)=X1(i-1)+X0(i);
end
for i=1:n-1
    B(i,1)=-1/2*(X1(i)+X1(i+1));
    B(i,2)=1;
    Y(i)=X0(i+1);
end
alpha=inv((B'*B))*B'*Y';
a=alpha(1,1);
b=alpha(2,1);
d=b/a;
c=X1(1)-d;
X2(1)=X0(1);
X(1)=X0(1);
for i=1:n-1
    X2(i+1)=c*exp(-a*i)+d;
    X(i+1)=X2(i+1)-X2(i);
end
for i=(n+1):(n+k)
    X2(i)=c*exp(-a*(i-1))+d;
    X(i)=X2(i)-X2(i-1);
end
for i=1:n
    error(i)=X(i)-X0(i);
    error1(i)=abs(error(i));
    error2(i)=error1(i)/X0(i);
end
r=std(error1)/std(X0);
if r<0.35 & r>0
    disp('The model is good');
end 
if r<0.5 & r>0.35
    disp('The model is eligibility');
end
if r<0.65 & r>0.5
    disp('The model is not good');
end
if r<1 & r>0.65
    disp('The model is bad');
end 
z=1:length(X0);
z1=1:length(X0)+k;
plot(z,X0,'-',z1,X,':')
text(2,X0(2),'History data:real line')
text(3,X(3),'Simulation data:broken line')
legend('real data','forecast data')
end