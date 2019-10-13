function root=HalfInterval(f,a,b,eps)
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
    root=FindRoots(f,a,b,eps);
end


function r=FindRoots(f,a,b,eps)
f_1=subs(sym(f),findsym(sym(f)),a);
f_2=subs(sym(f),findsym(sym(f)),b);
mf=subs(sym(f),findsym(sym(f)),(a+b)/2);
if(f_1*mf>0)
    t=(a+b)/2;
    r=FindRoots(f,t,b,eps);
else
    if(f_1*mf==0)
        r=(a+b)/2;
    else
        if(abs(b-a)<=eps)
            r=(b+3*a)/4;
        else
            s=(a+b)/2;
            r=FindRoots(f,a,s,eps);
        end
    end
end
    
