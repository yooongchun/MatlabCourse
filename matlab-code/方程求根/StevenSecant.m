function root=StevenSecant(f,a,b,eps)
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

if(f1*f2>0)
    disp('两端点函数值乘积大于0!');
    return;
else
    tol=1;
    fa=subs(sym(f),findsym(sym(f)),a);
    fb=subs(sym(f),findsym(sym(f)),b); 
    faa=subs(sym(f),findsym(sym(f)),fa+a);
    root=a-fa*fa/(faa-fa);
    while(tol>eps)
        r1=root;
        fx=subs(sym(f),findsym(sym(f)),r1);
        v=fx+r1;
        fxx=subs(sym(f),findsym(sym(f)),v);
        root=r1-fx*fx/(fxx-fx);
        tol=abs(root-r1);
    end
end
