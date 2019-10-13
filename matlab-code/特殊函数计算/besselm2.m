function Jx = besselm2(n,x)
format long;
if n == 0
    a = [-0.57721566;0.4227842;0.23069756;
          0.0348859;0.00262698;0.0001075;0.0000074];
    b = [1.25331414;-0.07832358;0.02189568;
        -0.01062446;0.00587872;-0.0025154;0.00053208];
    if x <= 2
        y = x^2/4;
        J0 = a(1);
        for i=2:7
            J0 = J0 + a(i)*power(y,(i-1));
        end
        J0 = J0 + besselm(0,x)*log(2/x);
    else
        z = 2/x;
        J0 = b(1);
        for i=2:7
            J0 = J0 + b(i)*power(z,(i-1));
        end
        J0 = J0*exp(-x)/sqrt(x);
    end
    Jx = J0;
else
    if n == 1
        a = [1.0;0.15443144;-0.67278579;
            -0.18156897;-0.01919402;-0.00110404;-0.00004686];
        b = [1.25331414;0.23498619;-0.0365562;
             0.01504268;-0.00780353;0.00325614;-0.00068245];
        if x<=2
            y = x^2/4;
            J0 = a(1)/x;
            for i=2:7
                J0 = J0 + a(i)*power(y,(i-1))/x;
            end
            J0 = J0 - besselm(1,x)*log(2/x);
        else
            z = 2/x;
            J0 = b(1);
            for i=2:7
                J0 = J0 + b(i)*power(z,(i-1));
            end
            J0 = J0*exp(-x)/sqrt(x);
        end
        Jx = J0;
    else
        k1 = besselm2(0,x);
        k2 = besselm2(1,x);
        for j=1:n-1
            Jx = 2*j*k2/x + k1;
            k1 = k2;
            k2 = Jx;
        end
    end
end
        
    