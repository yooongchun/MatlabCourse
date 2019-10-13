function l = hessqrtz(A,M)

A = hess(A);
for(i=1:M)
    [q,r]=qr(A);
    A = r*q;
    l = diag(A);
end