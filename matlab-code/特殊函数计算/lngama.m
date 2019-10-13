function lnTx = lngama(x)
format long;
c = [76.18009173;-86.50532033;24.01409822;
    -1.231739516;0.00120858003;-0.00000536382];
const1 = sqrt(2*pi);

if x>1
    T1 = (x-0.5)*log(x+4.5);
    T2 = 1;
    for i=1:6
        T2 = T2 + c(i)/(x-1+i);
    end
    lnTx = T1 - x - 4.5 + log(const1*T2);
else
    lnTx = lngama(x+1) - log(x);
end

    