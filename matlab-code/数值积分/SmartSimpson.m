function I=SmartSimpson(f,a,b,eps)
if(nargin==3)
    eps=1.0e-4;
end;
e=5*eps;
I=SubSmartSimpson(f,a,b,e);

function q=SubSmartSimpson(f,a,b,eps)
QA=IntSimpson(f,a,b,1,eps);
QLeft=IntSimpson(f,a,(a+b)/2,1,eps);
QRight=IntSimpson(f,(a+b)/2,b,1,eps);

if(abs(QLeft+QRight-QA)<=eps)
    q=QA;
else
    q=SubSmartSimpson(f,a,(a+b)/2,eps)+SubSmartSimpson(f,(a+b)/2,b,eps);
end


