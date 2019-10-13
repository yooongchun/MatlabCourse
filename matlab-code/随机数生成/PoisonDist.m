function x =PoisonDist(x0,lamda,n)
format long;
x = zeros(n,1);
for i=1:n
    b = 1;
    tol = 1;
    k = 0;
    while tol == 1
        r = MixMOD(x0,10,1);
        b = b*r(10); 
        if b < exp(-lamda)
            tol = 0 ;
            x(i) = k;
        else
            k = k+1;
        end
    end
    x0 = x0+31;
end    
format short;