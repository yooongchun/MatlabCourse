function [root,n]=StevenStablePoint(f,x0,eps)
if(nargin==2)
    eps=1.0e-4;
end

tol=1;
root=x0;
n=0;
while(tol>eps)
    n=n+1;
    r1=root;
    y=subs(sym(f),findsym(sym(f)),r1)+r1;
    z=subs(sym(f),findsym(sym(f)),y)+y;
    root=r1-(y-r1)^2/(z-2*y+r1);
    tol=abs(root-r1);
end