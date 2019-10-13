function [RegCoff,R,F,FX,TX]= PolyReg(X,Y,n)
format long;
sz = size(X);
N = sz(1);
XX = zeros(N,n);
for i=1:N
    for j=1:n
        XX(i,j) = X(i)^j;
    end
end

RegCoff = zeros(n+1,1);
Z = mean(XX);
yp = mean(Y);

A = transpose(XX)*XX - N*transpose(Z)*Z;
C = transpose(XX)*Y - N*transpose(Z)*yp;
RegCoff(2:n+1) = A\C;
RegCoff(1) = yp - Z*RegCoff(2:n+1);

S = norm(Y)^2 - N*yp^2;
YR = XX*RegCoff(2:n+1) + RegCoff(1)*ones(N,1);
U = transpose(RegCoff(2:n+1))*C;
Q = S-U;
R = sqrt(U/S);

UR = U/n;
QR = Q/(N-n-1);
s = sqrt(QR);

inA = inv(A);
F = UR/QR;
for i=1:length(RegCoff)-1
    FX(i) = RegCoff(i+1)^2/inA(i,i)/QR;
    TX(i) = RegCoff(i+1)/sqrt(inA(i,i))/s;
end
format short;
