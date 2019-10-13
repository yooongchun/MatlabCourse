function x = CauthyDist(x0,alpha,beta,n)
format long;
pi = 3.1415926535;
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,10,1);
    k = 0;
    while r(10) == 0
        k = k + 1;
        r(10) = power(2,k); 
        r = MixMOD(r(10),2,1);
    end
    y = tan(r(10)*pi);
    x(i) = alpha - beta/y;
    x0 = x(i);
end
format short;