function root=hj(f,a,b,eps)
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
    t1=a+(b-a)*0.382;
    t2=a+(b-a)*0.618;
    f_1=subs(sym(f),findsym(sym(f)),t1);
    f_2=subs(sym(f),findsym(sym(f)),t2); 
    tol=abs(t1-t2);
    while(tol>eps)                           %精度控制
        if(f_1*f_2<0)
            a=t1;
            b=t2;
        else
            fa=subs(sym(f),findsym(sym(f)),a);         
            if(f_1*fa>0)
                a=t2;
            else
                b=t1;
            end
        end
        t1=a+(b-a)*0.382;
        t2=a+(b-a)*0.618;
        f_1=subs(sym(f),findsym(sym(f)),t1);
        f_2=subs(sym(f),findsym(sym(f)),t2); 
        tol=abs(t2-t1);
    end
    root=(t1+t2)/2;                             %输出根
end


