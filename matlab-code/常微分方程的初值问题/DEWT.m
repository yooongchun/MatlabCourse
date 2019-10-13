function yy = DEWT(f,h,a,b,gama,y0,order,varvec)
format long;
ArrayH = [1;2;4;6;8;12;16;24;32;48;64;96];
N = (b-a)/h;
yy = zeros(N+1,1);

for i = 2:N+1
    dh = h;
    s = zeros(order,1);
    for j=1:order
        dh = h/ArrayH(j);
        tmpY = DELGKT2_suen(f,dh,a,a+(i-1)*h,y0,varvec);
        s(j) = tmpY((i-1)*ArrayH(j)+1);
    end
    tmpS = zeros(order,1);
    for j=1:order-1
        for k=(j+1):order
            tmpS(k) = s(k)+(s(k)-s(k-1))/((ArrayH(k)/ArrayH(j))^gama-1);
        end
        s(1:(order-j)) = tmpS((j+1):order);
    end
    yy(i) = tmpS(order);
end
format short;