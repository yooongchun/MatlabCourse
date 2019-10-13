function x =TwoDist(x0,p,n,N)
format long;
x = zeros(N,1);
for i=1:N
    y = BenuliDist(x0,p,n);
    x(i) = sum(y);
    x0 = 2*x0;
end    
format short;