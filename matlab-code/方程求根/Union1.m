function root = Union1(f,a,b,eps)
format long;
if(nargin==3)
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

tol=1;
df=diff(sym(f));                                 %Çóµ¼Êý
dfa=subs(sym(df),findsym(sym(df)),a);
x1 = a - fa/dfa;
x1_s = b - fb*(b-a)/(fb-fa);

while tol>eps
    fn=subs(sym(f),findsym(sym(f)),x1);
    dfn=subs(sym(df),findsym(sym(df)),x1);
    fn_s=subs(sym(f),findsym(sym(f)),x1_s);
    x2 = x1 - fn/dfn;
    x2_s = x1_s - (x1 - x1_s)*fn_s/(fn - fn_s);
    tol = abs(x2_s - x1_s);
    x1 = x2;
    x1_s = x2_s;
end
root = x2_s;    
format short;