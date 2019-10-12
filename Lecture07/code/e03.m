x=[58.2 56.2 65.3
   49.1 54.1 51.6
   60.1 70.9 39.2
   75.8 58.2 48.7];

[p,t,st]=anova2(x);
alpha=0.05;
if sum(p>alpha)>1
    fprintf('with p=%.4f,%.4f,we can accept H0\n',p);
else
    fprintf('with p=%.4f,%.4f,we can not accept H0\n',p);
end