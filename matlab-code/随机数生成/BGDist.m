function x =BGDist(x0,p,mu,sigma,n)
format long;
x = zeros(n,1);
for i=1:n
    y = BenuliDist(x0,p,10);
    z = GaussDist(2*x0,mu,sigma,10);
    x(i) = y(10)*z(10);
    x0 = 2*x0;
end    
format short;