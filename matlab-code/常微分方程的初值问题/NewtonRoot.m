function root=NewtonRoot(f,a,b,eps)
if(nargin==3)
    eps=1.0e-4;
end

f1=subs(sym(f),findsym(sym(f)),a);
f2=subs(sym(f),findsym(sym(f)),b);
if(f1==0)
    root=a;
end
if(f2==0)
    root=b;
end

tol=1;
fun=diff(sym(f));                                 %求导数
fa=subs(sym(f),findsym(sym(f)),a);
fb=subs(sym(f),findsym(sym(f)),b);  
dfa=subs(sym(fun),findsym(sym(fun)),a);
dfb=subs(sym(fun),findsym(sym(fun)),b);
if(dfa>dfb)                                         %初始值取两端点导数较大者
    root=a-fa/dfa;
else
    root=b-fb/dfb;
end
while(tol>eps)
    r1=root;
    fx=subs(sym(f),findsym(sym(f)),r1);
    dfx=subs(sym(fun),findsym(sym(fun)),r1);         %求该点的导数值
    root=r1-fx/dfx;                                          %迭代的核心公式
    tol=abs(root-r1);
end

