function [x,y]=eulerpro(fun,x0,xfinal,y0,n)
    if nargin<5
        n=50;
    end
    h=(xfinal-x0)/n;
    x(1)=x0;y(1)=y0;
    for i=1:n
        x(i+1)=x(i)+h;
        y1=y(i)+h*feval(fun,x(i),y(i));
        y2=y(i)+h*feval(fun,x(i+1),y1);
        y(i+1)=(y1+y2)/2;
    end
end