function coff=ZJPF(func,n,a,b)
C = zeros(n+1,n+1);
var = findsym(sym(func));
func = func/var;
for i=1:n+1
    C(1,i)=(power(b,i)-power(a,i))/i;       %算法中的C矩阵的第一行
    func = func*var;
    d(i,1)=int(sym(func),var,a,b);          %算法中的D向量的第一行
end

for i=2:n+1
    C(i,1:n)=C(i-1,2:n+1);
    f1 = power(b,n+i);
    f2 = power(a,n+i);
    C(i,n+1)=(f1-f2)/(n+i);                %形成C矩阵 
end
coff = C\d;                                %求解逼近多项式的系数
