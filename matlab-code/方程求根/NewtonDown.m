function root=NewtonDown(f,a,b,eps)
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
    fun=diff(sym(f));
    fa=subs(sym(f),findsym(sym(f)),a);
    fb=subs(sym(f),findsym(sym(f)),b); 
    dfa=subs(sym(fun),findsym(sym(fun)),a);
    dfb=subs(sym(fun),findsym(sym(fun)),b);
    if(dfa>dfb)
        root=a;
    else
        root=b;
    end
    while(tol>eps)
        r1=root;   
        fx=subs(sym(f),findsym(sym(f)),r1);    
        dfx=subs(sym(fun),findsym(sym(fun)),r1);
        toldf=1;
        alpha=2;
        while toldf>0
            alpha=alpha/2;
            root=r1-alpha*fx/dfx;
            fv=subs(sym(f),findsym(sym(f)),root);
            toldf=abs(fv)-abs(fx);
        end
        tol=abs(root-r1);
    end
end
