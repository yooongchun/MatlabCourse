function root=QBS2(f,a,b,x,eps)
format long;
if(nargin==4)
    eps=1.0e-6;
end

fa=subs(sym(f),findsym(sym(f)),a);
fb=subs(sym(f),findsym(sym(f)),b);
if(fa==0)
    root=a;
end
if(fb==0)
    root=b;
end

if(fa*fb>0)
    disp('两端点函数值乘积大于0!');
    return;
else
    tol=1;
    t=zeros(3);
    t(1)=a;
    t(2)=b;
    t(3)=x;
    while(tol>eps)
        f1=subs(sym(f),findsym(sym(f)),t(1));         %计算三点的函数值
        f2=subs(sym(f),findsym(sym(f)),t(2));
        tx = (t(3)+t(2))/2;
        f3=subs(sym(f),findsym(sym(f)),tx);
        d1=f2-f1;                           
        d2=f3-f2;
        d3=f3-f1;                              
        root=t(1)*f2*f3/d1/d3+t(2)*f1*f3/d1/d2+tx*f2*f1/d2/d3;  
        tol=abs(root-tx);
        t(1)=t(2);                                           %保存三个点
        t(2)=t(3);
        t(3)=root;
    end
end
format short;