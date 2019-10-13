function x = WBDist(x0,alpha,beta,n)
format long;
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,10,1);
    k = 0;
    while r(10) == 0
        k = k + 1;
        r(10) = power(2,k); 
        r = MixMOD(r(10),2,1);
    end
    t = 1/alpha;
    y =  -log(r(10));
    x(i) = beta*power(y,t);
    x0 = x(i);
end
format short;
