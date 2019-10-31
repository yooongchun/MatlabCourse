y=[6.35 6.20 6.22 6.66 7.15 7.89 8.72 8.94 9.28 9.8];
w=[1/6;2/6;3/6];
m=length(y);n=3;
yhat=zeros(1,m-n+1);
for i=1:m-n+1
  yhat(i)=y(i:i+n-1)*w;
end
yhat
err=abs(y(n+1:m)-yhat(1:end-1))./y(n+1:m)
T_err=1-sum(yhat(1:end-1))/sum(y(n+1:m))
y1989=yhat(end)/(1-T_err)