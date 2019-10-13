function root = Union2(f,a,b,eps)
format long;
if(nargin==3)
    eps=1.0e-4;
end

fa=subs(sym(f),findsym(sym(f)),a);
fb=subs(sym(f),findsym(sym(f)),b);
if(fa==0)
    root=a;
end
if(fb==0)
    root=b;
end

tol=1;
df=diff(sym(f));                                 %Çóµ¼Êý
dfb=subs(sym(df),findsym(sym(df)),b);
x1 = a - (b-a)*fa/(fb-fa);
x1_s = b - fb/dfb;

while tol>eps
    fn = subs(sym(f),findsym(sym(f)),x1);
    dfn_s = subs(sym(df),findsym(sym(df)),x1_s);
    fn_s = subs(sym(f),findsym(sym(f)),x1_s);
    x2 = x1 - (x1_s - x1)*fn/(fn_s - fn);
    x2_s = x1_s - fn_s/dfn_s ;
    tol = abs(x2_s - x1_s);
    x1 = x2;
    x1_s = x2_s;
end
root = x2_s; 
format short;