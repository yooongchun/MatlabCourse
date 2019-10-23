function y=findrow(x,b)
[row_x,colomn_x]=size(x);
j=1;
for i=1:row_x
    if(x(i,:)==b)
        y(j)=i;
        j=j+1;
    end
end