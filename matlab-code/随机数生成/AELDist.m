function x = AELDist(x0,m,beta,n)
format long;
x = zeros(n,1);
u = zeros(m,1);
for i=1:n
    for j=1:m
        r = MixMOD(x0,10,1);
        k = 0;
        while r(10) == 0
            k = k + 1;
            r(10) = power(2,k); 
            r = MixMOD(r(10),2,1);
        end
        u(j) = r(10);
        x0 = u(j);
        x(i) = x(i) - beta*log(u(j));
    end    
    x0 = x(i);
end
format short;