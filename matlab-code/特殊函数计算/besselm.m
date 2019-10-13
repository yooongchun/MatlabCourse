function Jx = besselm(n,x)
format long;
if n == 0
    a = [1.0;3.5156229;3.0899424;1.2067492;
         0.2659732;0.0360768;0.0045813];
    b = [0.39894228;0.01328592;0.00225319;
        -0.00157565;0.00916281;-0.02057706;
         0.02635537;-0.01647633;0.00392377];
    if abs(x) < 3.75
        y = x^2/3.75/3.75;
        J0 = a(1);
        for i=2:7
            J0 = J0 + a(i)*power(y,(i-1));
        end
    else
        z = 3.75/abs(x);
        J0 = b(1);
        for i=2:9
            J0 = J0 + b(i)*power(z,(i-1));
        end
        J0 = J0*exp(abs(x))/sqrt(abs(x));
    end
    Jx = J0;
else
    if n == 1
        a = [0.5;0.87890594;0.51498869;
             0.15084934;0.02658773;0.00301532;0.00032411];
        b = [0.39894228;-0.03988024;-0.00362018;
             0.00163801;-0.01031555;0.02282967;
            -0.02895312;0.01787654;,-0.00420059];
        if abs(x) < 3.75
            y = x^2/3.75/3.75;
            J0 = a(1);
            for i=2:7
                J0 = J0 + a(i)*power(y,(i-1));
            end
            J0 = x*J0;
        else
            z = 3.75/abs(x);
            J0 = b(1);
            for i=2:9
                J0 = J0 + b(i)*power(z,(i-1));
            end
            J0 = J0*exp(abs(x))/sqrt(abs(x));
        end
        Jx = J0;
    else
        M = 2*floor(((n + floor(sqrt(40*n))))/2);
        JS = zeros(M+2 ,1);
        JS(M+2) = 0;
        JS(M+1) = 1;
        y = 2/x;
        for k=M:-1:1
            JS(k) = JS(k+1)*y*k + JS(k+2);
        end
        Jx = besselm(0,x)*JS(n+1)/JS(1);
    end
end
        
    