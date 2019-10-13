function [RegCoff,R,F,FX,TX]= CompPoly2Reg(X,Y)
format long;
sz = size(X);
N = sz(1);
n = sz(2);
XX = zeros(N,n);
XX(:,1) = X(:,1);
XX(:,4) = X(:,2);
for i=1:N
    XX(i,2) = X(i,1)^2;
    XX(i,3) = X(i,1)*X(i,2);
    XX(i,5) = X(i,2)^2;
end

RegCoff = zeros(6,1);
Z = mean(XX);
yp = mean(Y);

A = transpose(XX)*XX - N*transpose(Z)*Z;
C = transpose(XX)*Y - N*transpose(Z)*yp;
RegCoff(2:6) = A\C;
RegCoff(1) = yp - Z*RegCoff(2:6);

S = norm(Y)^2 - N*yp^2;
YR = XX*RegCoff(2:6) + RegCoff(1)*ones(N,1);
U = transpose(RegCoff(2:6))*C;
Q = S-U;
R = sqrt(U/S);

UR = U/n;
QR = Q/(N-6);
s = sqrt(QR);

inA = inv(A);
F = UR/QR;
for i=1:length(RegCoff)-1
    FX(i) = RegCoff(i+1)^2/inA(i,i)/QR;
    TX(i) = RegCoff(i+1)/sqrt(inA(i,i))/s;
end
format short;
