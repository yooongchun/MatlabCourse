c=[2;3;1];
a=[1 4 2;3 2 0];
b=[8;6];
[x,y]=linprog(c,-a,-b,[],[],zeros(3,1));
fprintf('x1=%.4f,x2=%.4f,x3=%.4f,y=%.4f\n',x,y);