function kc = ZYFG(X,k)
format long;
n = length(X);
kc = zeros(k,1);
kc(k) = n;

for s=1:k-1
    minD = inf;
    for i=k-s+1:kc(k)
        Dc = Dg(X,1,i-1) + Dg(X,i,kc(k-s+1));
        if Dc < minD
            minD = Dc;
            kc(k-s) = i-1;
        end
    end
end
format short;            
    
function Diameter = Dg(X,i,j)
format long;
meanX = sum(X(i:j))/(j-i+1);

Diameter = dot(X(i:j)-meanX*ones(size(X(i:j))),X(i:j)-meanX*ones(size(X(i:j))));



