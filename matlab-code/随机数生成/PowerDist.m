function x = PowerDist(x0,beta,n)
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,2,1);
    k = 0;
    while r(2) == 0
        k = k + 1;
        r(2) = power(2,k); 
        r = MixMOD(r(2),2,1);
    end
    x(i) = -beta*log(r(2));
    x0 = x(i);
end
    