function x = LaplaceDist(x0,x1,beta,n)
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,10,1);
    u = MixMOD(x1,10,2);
    k = 0;
    while (r(10) == 0 || u(10) == 0)
        k = k + 1;
        r(10) = power(2,k); 
        u(10) = power(2,power(2,k));
        r = MixMOD(r(10),2,1);
        u = MixMOD(u(10),2,2);
    end
    if r(10) <= 0.5
        x(i) = -beta*log(1-u(10));
    else
        x(i) = beta*log(u(10)); 
    end
    x0 = x1;
    x1 = x(i);
end