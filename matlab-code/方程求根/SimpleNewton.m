function root=SimpleNewton(f,a,b,eps)
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
        df0=1/dfa;
        root=a-df0*fa;
    else
        df0=1/dfb;
        root=b-df0*fb;
    end
    while(tol>eps)
        r1=root;   
        fx=subs(sym(f),findsym(sym(f)),r1); 
        root=r1-df0*fx;
        tol=abs(root-r1);
    end
end
