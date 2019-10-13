function xm = BenvliMAX(a,eps)
format long;
if(nargin==1)
    eps=1.0e-4;
end
n = length(a);
y = zeros(n+1,1);
y(n) =1;
tol = 1;
xm = inf;
while tol>eps
    xm1 = xm;
    y(n+1) =dot(-a,y(1:n));
    y(1:n) = y(2:n+1);
    xm = y(n)/y(n-1);
    tol = abs(xm-xm1);
end
format short;
