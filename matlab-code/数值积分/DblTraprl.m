function q=DblTraprl(f,a,A,b,B,m,n)
if(m==1 && n==1)           %梯形公式
    q=((B-b)*(A-a)/4)*(subs(sym(f),findsym(sym(f)),{a,b})+...
        subs(sym(f),findsym(sym(f)),{a,B})+...
        subs(sym(f),findsym(sym(f)),{A,b})+...
        subs(sym(f),findsym(sym(f)),{A,B}));
    
else                       %复合梯形公式
    C=4*ones(n+1,m+1);
    C(1,:)=2;
    C(:,1)=2;
    C(n+1,:)=2;
    C(:,m+1)=2;
    C(1,1)=1;
    C(1,m+1)=1;
    C(n+1,1)=1;
    C(n+1,m+1)=1;           %C矩阵
end

F=zeros(n+1,m+1);
q=0;
for i=0:n
   for j=0:m
       x=a+i*(A-a)/n;
       y=b+j*(B-b)/m;
       F(i+1,j+1)=subs(sym(f),findsym(sym(f)),{x,y});
       q=q+F(i+1,j+1)*C(i+1,j+1);
   end
end

q=((B-b)*(A-a)/4/m/n)*q;