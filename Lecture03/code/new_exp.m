function y=new_exp(x)
    n=100;
    y=1;
    for i=1:n
       y=y+x^i/factorial(i); 
    end
end