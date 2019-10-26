%% ÒÅ´«Ä£ÐÍ

syms n a0 b0 c0
M=sym([1,1/2,0;0,1/2,1;0,0,0]);
[p,lamda]=eig(M);
x=p*lamda.^n*p^(-1)*[a0;b0;c0];
x=simplify(x)  