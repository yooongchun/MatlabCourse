function root=ModifSecant(f,a,b,eps)
format long;
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
    tol = 1;
    r1 = a;                         %迭代初始值
    r2 = b; 
    fv = subs(sym(f),findsym(sym(f)),a);
    while(tol>eps)
        f2=subs(sym(f),findsym(sym(f)),r2);
        root=r2-(r2-r1)*f2/(f2-fv);  
        fr=subs(sym(f),findsym(sym(f)),root);
        if(f2*fr<0)
            tol=abs(root-r2);
            r1 = r2;
            r2 = root;
            fv = subs(sym(f),findsym(sym(f)),r1);
        else
            tol=abs(root-r2);
            r2 = root;
            fv = 0.5*subs(sym(f),findsym(sym(f)),r1); 
        end        
    end
end
format short;
