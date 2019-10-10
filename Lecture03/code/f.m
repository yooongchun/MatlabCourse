function z=f(x,y)
    if x>0 && y>0
        z=x+y;
    elseif x>0 && y<=0
        z=x+y.^2;
    elseif x<=0 && y>0
        z=x.^2+y;
    else
        z=x.^2+y.^2;
    end
end

