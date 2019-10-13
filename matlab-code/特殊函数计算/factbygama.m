function y = factbygama(n)
format long;
y = 1;
if n <= 32 
    for i=1:n
        y = y*i;
    end
else
    y = exp(lngama(n+1));
end
