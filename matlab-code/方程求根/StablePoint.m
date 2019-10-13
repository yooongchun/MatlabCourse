function [root,n]=StablePoint(f,x0,eps)
if(nargin==2)
    eps=1.0e-4;
end

tol=1;
root=x0;
n=0;
while(tol>eps)
    n=n+1;
    r1=root;
    root=subs(sym(f),findsym(sym(f)),r1)+r1;
    tol=abs(root-r1);
end

