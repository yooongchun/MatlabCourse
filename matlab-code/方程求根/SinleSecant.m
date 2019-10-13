function root=SinleSecant(f,a,b,eps)
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
    root=b;                         %迭代初始值
    while(tol>eps)
        n = n+1;
        r1=root;
        fx=subs(sym(f),findsym(sym(f)),r1);
        s=fx*fa;
        if(s==0)
            root=r1;
        else
            root=r1-(r1-a)*fx/(fx-fa);             %用递推公式1
        end
        tol=abs(root-r1);
    end
end