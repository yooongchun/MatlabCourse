function [p,q]=PYZ(a,M,p0,q0)
format long;
n = length(a);
b = zeros(n,1);
c = zeros(n-1,1);
p = p0;
q = q0;

for k=1:M
    b(1) = 0;
    b(2) = 1;
    for i=3:n
        b(i) = a(i-2) - p*b(i-1)-q*b(i-2);
    end
    r1 = a(n-1) - p*b(n)-q*b(n-1);
    r2 = a(n) - q*b(n);

    c(1) = 0;
    c(2) = 1;
    for i=3:n-1
        c(i) = b(i) - p*c(i-1)-q*c(i-2);
    end
    R11 = b(n) - p*c(n-1)-q*c(n-2);
    R12 = -q*c(n-1);

    R21 = b(n-1) - p*c(n-2)-q*c(n-3);
    R22 = b(n)-q*c(n-2);

    A = [R11 R21;R22 R12];
    B = [r1;r2];
    u = A\B;
    p = p+u(1);
    q = q+u(2);
end
format short;
