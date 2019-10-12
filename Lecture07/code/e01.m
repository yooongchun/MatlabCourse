x=[256 254 250 248 236
   242 330 277 280 252
   280 290 230 305 220
   298 295 302 289 252];
p=anova1(x);

alpha=0.05;
if p>alpha
    fprintf('with p=%.4f,we can accept H0\n',p);
else
    fprintf('with p=%.4f,we can not accept H0\n',p);
end