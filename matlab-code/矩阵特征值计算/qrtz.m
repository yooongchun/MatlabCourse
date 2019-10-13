function l = qrtz(A,M)

for(i=1:M)                 %M为迭代步数
    [q,r]=qr(A);
    A = r*q;
    l = diag(A);
end
