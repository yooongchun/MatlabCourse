function root=QBS(f,a,b,x,eps)
format long;
if(nargin==4)
    eps=1.0e-6;
end

fa=subs(sym(f),findsym(sym(f)),a);
fb=subs(sym(f),findsym(sym(f)),b);
fx=subs(sym(f),findsym(sym(f)),x);
if(fa==0)
    root=a;
    return;
end
if(fb==0)
    root=b;
    return;
end

if(fx == 0)
    root = x;
    return;
else
    tol=1;
    t=zeros(3);
    t(1)=a;
    t(2)=x;
    t(3)=b;
    while(tol>eps)
        f1=subs(sym(f),findsym(sym(f)),t(1));         %计算三点的函数值
        f2=subs(sym(f),findsym(sym(f)),t(2));
        f3=subs(sym(f),findsym(sym(f)),t(3));
        d1=f2-f1;                           
        d2=f3-f2;
        d3=f3-f1; 
        if (d1 == 0 || d2 == 0 || d3 == 0)
            disp('除0错误，请重新选择三个初始点！');
            root = NaN;
            return;
        end
        root=t(1)*f2*f3/d1/d3+t(2)*f1*f3/d1/d2+t(3)*f2*f1/d2/d3;  
        tol=abs(root-t(3));
        ft = subs(sym(f),findsym(sym(f)),root);
        if( f2*ft < 0)
            if root > t(2)
                t(1)=t(2);                                          
                t(2)=root;
            else
                t(3) = t(2);
                t(2) = root;
            end
        else
            if f2 < 0
                if root > t(2)
                    t(1)=t(2);                                          
                    t(2)=root;
                else
                    t(1) = root;
                end
            else
                if root > t(2)
                    t(3) = root;
                else
                    t(3) = t(2);
                    t(2) = root;
                end
            end
        end
    end
end
format short;
