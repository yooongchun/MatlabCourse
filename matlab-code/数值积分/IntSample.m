function q = IntSample(func,a,b,n)
format long;
node_num = n + 3;      %加上延拓的2个节点共n+3个节点
h = (b-a)/n;
for i=1:node_num
     y(i) = subs(sym(func), findsym(sym(func)), a+i*h-2*h);
end

y_1 = (-3*y(1)+4*y(2)-y(3))/(2*h);
y_N = (3*y(node_num)-4*y(node_num-1)+3*y(node_num-2))/(2*h);
c = SubBSample(h,node_num-1,y,y_1,y_N);  %用样条逼近法求出样条系数
q = h*(c(1)+c(node_num+2))/24+h*(c(2)+c(node_num+1))/2+23*h*(c(3)+c(node_num))/24;;
for j=4:node_num-1
    q = q+h*c(j);
end
format short;

function c = SubBSample(h,n,y,y_1,y_N)
f0 = 0.0;
c = zeros(n+3,1);
b = zeros(n+1,1);


A = diag(4*ones(n+1,1));
I = eye(n+1,n+1);
AL = [I(2:n+1,:);zeros(1,n+1)];
AU = [zeros(1,n+1);I(1:n,:)];
A = A+AL+AU;                      %形成系数矩阵
for i=2:n
    b(i,1) = 6*y(i);
end
b(1) = 6*y(1)+2*h*y_1;
b(n+1) = 6*y(n+1)-2*h*y_N;
d = followup(A,b);          %用追赶法求出系数
c(2:n+2) = d;
c(1) = c(2) - 2*h*y_1;      %c(-1)
c(n+3) = c(3)+2*h*y_N;      %c(n+1)
