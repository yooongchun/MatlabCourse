function r =CombineLinear(x0,L,n)
format long;
r = zeros(n,1);
M = power(2,L);
q = (L+1) /2;
S = 6;
a = [0;1;3;5;7;9];
c = power(2,q)-a;
for i=1:n
    tol = 1;
    while tol == 1
        zs = MixMOD(x0,10,1);
        t = zs(10)*6;
        j = floor(t)+1;
    
        x = a(j)*x0+c(j);
        x = mod(x, M);

        d = mod(x,power(2,q));
        b = (x-d)/power(2,q);
        if d>=a(j)
            r(i) = b/power(2,L-q);
            x0 = r(i);
            tol = 0;
        else
            x0 = x0 + 31;
        end 
    end
end    
format short;