clc,clear
load dianqi.txt %????????????????????
yt=dianqi; n=length(yt);
alpha=[0.2 0.5 0.8];m=length(alpha);
yhat(1,1:m)=(yt(1)+yt(2))/2;
for i=2:n
yhat(i,:)=alpha*yt(i-1)+(1-alpha).*yhat(i-1,:);
end
yhat
err=sqrt(mean((repmat(yt,1,m)-yhat).^2))
yhat1988=alpha*yt(n)+(1-alpha).*yhat(n,:)