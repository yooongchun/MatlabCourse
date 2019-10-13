function df0 = SmartDF(func,x0,eps)
format long;
if nargin == 2
    eps = 1.0e-4;
end

df0_tmp = Inf;    
n = 2;
h = 0.1;
con = 1;

while con
    node_num = 2*n + 1;
    hd = 1/2/h;
    x = (x0-n*h):h:(x0+n*h);
    for i=1:node_num
        y(i) = subs(sym(func), findsym(sym(func)), x(i));
    end

    y_1 = (-3*y(1)+4*y(2)-y(3))*hd;
    y_N = (3*y(node_num)-4*y(node_num-1)+3*y(node_num-2))*hd;
    c = SubBSample(h,2*n,y,y_1,y_N);
    df0 = (c(n+2)-c(n))*hd;
    if abs(df0 - df0_tmp) <= eps
        con = 0;
    else
        df0_tmp = df0;
        n = n+4;
        h = h*0.75;
    end
end
