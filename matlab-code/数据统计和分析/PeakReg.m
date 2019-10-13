function [RegCoff,R,F,FX,TX]= PeakReg(X,Y,k)
format long;
sz = size(X);
N = sz(1);
n = sz(2);
XX = [ones(N,1) X];
RegCoff = inv(transpose(XX)*XX+k*eye(N,N))*transpose(XX)*Y;
Z = mean(X);
yp = mean(Y);


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
