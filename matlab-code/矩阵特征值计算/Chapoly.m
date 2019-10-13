function l = Chapoly(A)
syms t;

N = size(A);
n = N(1,1);

y = det(A-t*eye(n,n));
l = solve(y);
l = vpa(l, 5);         %结果取五位精度