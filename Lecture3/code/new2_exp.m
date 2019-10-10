function [n,y]=new2_exp(x)
    diff=0.001;
    y=1;
    n=0;
    while abs(exp(x)-y)>diff
        n=n+1;
        y=y+x^n/factorial(n);
    end
end