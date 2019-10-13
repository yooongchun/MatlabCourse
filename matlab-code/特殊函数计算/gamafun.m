function gx = gamafun(x)
format long;
if x < 0
    disp('x±ØÐë´óÓÚ0£¡');
    return;
else
    if x<= 1
        gx = gf(x+2)/x/(x+1);
    else 
        if x<=2
            gx = gf(x+1)/x;
        else
            if x<=3
                gx = gf(x);
            else
                k = floor(x) - 2;
                c = 1;
                for i=1:k
                    c = c*(x-i);
                end
                gx = c*gf(x-k);
            end
        end
    end
end

function tx = gf(x)
format long;
c = [0.0000677106;-0.0003442342;0.0015397681;
    -0.0024467480;0.0109736958;-0.0002109075;
    0.0742379071;0.0815782188;0.4118402518;
    0.4227843370;1.00000000];
tx = 0;
for i=1:11
    tx = tx + c(i)*power(x-2,11-i);
end
