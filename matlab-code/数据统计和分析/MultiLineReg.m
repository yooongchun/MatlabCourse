function [RegCoff,R,F,FX,TX]= MultiLineReg(X,Y)
format long;
sz = size(X);
N = sz(1);
n = sz(2);
RegCoff = zeros(n+1,1);
Z = mean(X);
yp = mean(Y);

A = transpose(X)*X - N*transpose(Z)*Z;
C = transpose(X)*Y - N*transpose(Z)*yp;
RegCoff(2:n+1) = A\C;
RegCoff(1) = yp - Z*RegCoff(2:n+1);

S = norm(Y)^2 - N*yp^2;
YR = X*RegCoff(2:n+1) + RegCoff(1)*ones(N,1);
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
