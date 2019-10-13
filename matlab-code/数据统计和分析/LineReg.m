function [RegCoff,R,F,FX,TX]= LineReg(X,Y)
format long;
n = length(Y);
Z = [ones(n,1) X];

A = inv(transpose(Z)*Z);
RegCoff = A*transpose(Z)*Y;

yp = mean(Y);
S = norm(Y)^2 - 2*yp*yp*n + n*yp^2;
YR = Z*RegCoff;
U = norm(YR)^2 - 2*yp*sum(YR) + n*yp^2;
Q = S-U;
R = sqrt(U/S);

UR = U/(length(RegCoff)-1);
QR = Q/(n -length(RegCoff));
s = sqrt(QR);

F = UR/QR;
for i=1:length(RegCoff)-1
    FX(i) = RegCoff(i+1)^2/A(i,i)/QR;
    TX(i) = RegCoff(i+1)/sqrt(A(i,i))/sqrt(QR);
end
format short;
