function x = GaussDist(x0,mu,sigma,n)
format long;
x = zeros(n,1);
u = zeros(12,1);
for i=1:n
    y = -6;
    for j=1:12
        r = MixMOD(x0,10,1);
        k = 0;
        while r(10) == 0
            k = k + 1;
            r(10) = power(2,k); 
            r = MixMOD(r(10),2,1);
        end
        u(j) = r(10);
        x0 = u(j);
        y = y + u(j);
    end
    x(i) = mu + sigma*y;
    x0 = x(i);
end
format short;