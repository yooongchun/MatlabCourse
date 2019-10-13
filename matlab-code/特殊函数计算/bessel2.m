function Jx = bessel2(n,x)
format long;
if n == 0
    a = [-2.957821389e9;7.062834065e9;-5.123598036e8;
         1.087988129e7;-8.632792757e4;2.284622733e2];
    b = [4.0076544269e10;7.452499648e8;7.189466438e6;
         4.744726470e4;2.261030244e2;1.0];
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
        J0 = J0_u/J0_d+2*bessel(0,x)*log(x)/pi;
    else
        z = 8/abs(x);
        sita = abs(x) - pi/4;
        R0 = r(1);
        S0 = s(1);
        for i=2:5
            R0 = R0 + r(i)*power(z,2*(i-1));
            S0 = S0 + s(i)*power(z,2*(i-1));
        end
        J0 = (R0*sin(sita)+z*S0*cos(sita))*sqrt(2/pi/abs(x));
    end
    Jx = J0;
else
    if n == 1
        c = [-4.900604943e12;1.275274390e12;-5.153438139e10;
            7.439264551e8;-4.237922726e6;8.511937935e3];
        d = [2.499580570e13;4.244419664e11;3.733650367e9;
            2.245904002e7;1.020426050e5;3.549632885e2;
            1.0];
        p = [1.0;0.183105e-2;-0.3516396496e-4;
            0.2457520174e-5;-0.240337019e-6];
        q = [0.4687499995e-1;-0.2002690873e-3;
            0.8449199096e-5;-0.88228987e-6;
            0.105787412e-6];
        if x < 8
            J1_u = c(1);
            J1_d = d(1);
            for i=2:6
                J1_u = J1_u + c(i)*power(x,2*(i-1));
                J1_d = J1_d + d(i)*power(x,2*(i-1));
            end
            J1_d = J1_d + d(7)*power(x,12);
            J1 = x*J1_u/J1_d+2*(bessel(1,x)*log(x)-1/x)/pi;
        else
            z = 8/abs(x);
            fi = abs(x) - 3*pi/4;
            P1 = p(1);
            Q1 = q(1);
            for i=2:5
                P1 = P1 + p(i)*power(z,2*(i-1));
                Q1 = Q1 + q(i)*power(z,2*(i-1));
            end
            J1 = (P1*sin(fi)+z*Q1*cos(fi))*sqrt(2/pi/abs(x));
        end
        Jx = J1;
    else
        y = 2/x;
        bess1 = bessel2(0,x);
        bess2 = bessel2(1,x);
        for j=1:n-1
            Jx = j*y*bess2 - bess1;
            bess1 = bess2;
            bess2 = Jx;
        end
    end
end
        
    