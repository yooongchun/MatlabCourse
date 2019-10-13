function ei = EIx2(x)
if x < 0
    disp('x±ØÐë´óÓÚ0!');
    return;
end

format long;
cof = [-0.57721566;0.99999193;-0.24991055;
        0.05519968;-0.0097004;0.00107857];
cr = [0.2677737343;8.6347608925;18.059016973;
      8.5733287401;1.0];
cs = [3.9584969228;21.0996530827;25.6329561486;
      9.5733223454;1.0];

if x < 1
    ei = log(x);
    for i=1:6
        ei = ei - cof(i)*power(x,i-1);
    end
else
    ei = -exp(-x)/x;
    ER = 0;
    ES = 0;
    for i=1:5
        ER = ER + cr(i)*power(x,i-1);
        ES = ES + cs(i)*power(x,i-1);
    end
    ei = ei*ER/ES;
end