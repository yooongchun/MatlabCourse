function xm = BenvliMIN(a,eps)
format long;
if(nargin==1)
    eps=1.0e-4;
end
n = length(a);
y = zeros(n+1,1);
y(n) =1;
am(1:n) = a(n:-1:1);
c = am(n);
am(2:n) = am(1:n-1);
am(1) = 1;
am(1:n) = -am(1:n)/c;
tol = 1;
xm = inf;
while tol>eps
    xm1 = xm;
    y(n+1) =dot(am,y(1:n));
    y(1:n) = y(2:n+1);
    xm =y(n-1)/y(n);
    tol = abs(xm-xm1);
end
format short;
