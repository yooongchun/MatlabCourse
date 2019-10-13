function numDist = test(x0,N)
x = GaussDist (x0,5,2,N);
mi = floor(min(x));
ma =  ceil(max(x));
numDist = zeros(ma-mi,1);

for i=1:N
    j = floor(x(i)) - mi;
    numDist(j+1) = numDist(j+1) + 1;
end

t=1:(ma-mi);
bar(t,numDist);
