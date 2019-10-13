function root=PallSecant(f,a,b,eps)
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
    tol=1;
    root=a;                         %迭代初始值
    c = (b-a)/(f2-f1);
    while(tol>eps)
        r1 = root;
        fx=subs(sym(f),findsym(sym(f)),r1);
        if(f1==0)
            root=r1;
        else
            root=r1-c*fx;               
        end
        tol=abs(root-r1);
    end
end
format short;
