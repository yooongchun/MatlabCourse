function q = IntDBGauss(func,a,b,c,d,m,n)
format long;
ta = (b-a)/2;
tb = (a+b)/2;
tc = (d-c)/2;
td = (c+d)/2;
f = zeros(n,m);
node_x = [0 0 0 0 0;-0.5773503  0.5773503 0 0 0;-0.7745967  0  0.7745967  0 0;
         -0.8611363  -0.3398810  0.3398810  0.8611363 0;
         -0.9061793  -0.5384693  0  0.5384693  0.9061793];   %高斯积分点坐标矩阵
node_A = [2 0 0 0 0;1  1 0 0 0;0.5555556  0.8888889  0.5555556   0 0;
         0.3478548  0.6521453   0.6521453  0.3478548  0;
         0.2369269  0.4786287  0.5688889  0.4786287  0.2369269];
            %高斯积分系数矩阵
for i=1:m
   for j=1:n
       f(j,i) = subs(sym(func),findsym(sym(func)),[ta*node_x(m,i)+tb tc*node_x(n,i)+td]);
   end
end
Am = transpose(node_A(m,1:m));
An = node_A(n,1:n);
q =ta*tc* An*f*Am;
format short;
