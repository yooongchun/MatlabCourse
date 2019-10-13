function c = DFF(f,N)
c(1:N)=0;
for(m=1:N)
    for(n=1:N)
        c(m)=c(m)+f(n)*exp(-i*m*n*2*pi/N);
    end
    c(m)=c(m)/N;
end