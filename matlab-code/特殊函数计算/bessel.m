function Jx = bessel(n,x)
format long;
if n == 0
    a = [5.7568490574e10;-1.3362590354e10;6.516196407e8;
         -1.121442418e7;7.739233017e4;-1.849052456e2];
    b = [5.7568490411e10;1.029532985e9;9.494680718e6;
         5.927264853e4;2.678532712e2;1.0];
    r =[1.0;-0.1098628627e-2;0.2734510407e-4;
        -0.2073370639e-5;0.2093887211e-6];
    s =[-0.1562499995e-1;0.1430488765e-3;-0.6911147651e-5;
        0.7621095161e-6;-0.934945152e-7];
    if abs(x) < 8
        J0_u = a(1);
        J0_d = b(1);
        for i=2:6
            J0_u = J0_u + a(i)*power(x,2*(i-1));
            J0_d = J0_d + b(i)*power(x,2*(i-1));
        end
        J0 = J0_u/J0_d;
    else
        z = 8/abs(x);
        sita = abs(x) - pi/4;
        R0 = r(1);
        S0 = s(1);
        for i=2:5
            R0 = R0 + r(i)*power(z,2*(i-1));
            S0 = S0 + s(i)*power(z,2*(i-1));
        end
        J0 = (R0*cos(sita)-z*S0*sin(sita))*sqrt(2/pi/abs(x));
    end
    Jx = J0;
else
    if n == 1
        c = [7.2362614232e10;-7.895059235e9;2.423968531e8;
            -2.972611439e6;1.570448260e4;-3.016036606e1];
        d = [1.44725228443e11;2.300535178e9;1.858330474e7;
            9.944743994e4;3.769991397e2;1.0];
        p = [1.0;0.183105e-2;-0.3516396496e-4;
            0.2457520174e-5;-0.240337019e-6];
        q = [0.4687499995e-1;-0.2002690873e-3;
            0.8449199096e-5;-0.88228987e-6;
            0.105787412e-6];
        if abs(x) < 8
            J1_u = c(1);
            J1_d = d(1);
            for i=2:6
                J1_u = J1_u + c(i)*power(x,2*(i-1));
                J1_d = J1_d + d(i)*power(x,2*(i-1));
            end
            J1 = x*J1_u/J1_d;
        else
            z = 8/abs(x);
            fi = abs(x) - 3*pi/4;
            P1 = p(1);
            Q1 = q(1);
            for i=2:5
                P1 = P1 + p(i)*power(z,2*(i-1));
                Q1 = Q1 + q(i)*power(z,2*(i-1));
            end
            J1 = (P1*cos(fi)-z*Q1*sin(fi))*sqrt(2/pi/abs(x));
            if x<0
                J1 = -J1;
            end
        end
        Jx = J1;
    else
        if abs(x) > n
            y = 2/x;
            bess1 = bessel(0,x);
            bess2 = bessel(1,x);
            for j=1:n-1
                Jx = j*y*bess2 - bess1;
                bess1 = bess2;
                bess2 = Jx;
            end
        else
            M = 2*floor(((n + floor(sqrt(40*n))))/2);
            JS = zeros(M+2 ,1);
            JS(M+2) = 0;
            JS(M+1) = 1;
            y = 2/x;
            bSum = 0;
            for k=M:-1:1
                JS(k) = JS(k+1)*y*k - JS(k+2);
            end
            BK = JS(1);
            for k=1:floor(M/2)
                BK = BK + 2*JS(2*k+1);
            end
            Jx = JS(n+1)/BK;
        end
    end
end
        
    