function x =BenuliDist(x0,p,n)
format long;
x = zeros(n,1);
for i=1:n
    r = MixMOD(x0,10,1);
    if r(10) <= p
        x(i) = 1;
    else
        x(i) = 0;
    end
    x0 = 2*x0;
end    
format short;