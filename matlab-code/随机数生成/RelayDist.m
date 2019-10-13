function x = RelayDist(x0,sigma,n)
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,10,1);
    k = 0;
    while r(10) == 0
        k = k + 1;
        r(10) = power(2,k); 
        r = MixMOD(r(10),2,1);
    end
    y =  -2*log(r(10));
    x(i) = sigma*sqrt(y);
    x0 = x(i);
end