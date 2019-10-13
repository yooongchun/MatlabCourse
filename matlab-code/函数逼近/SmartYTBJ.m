function [node,err] = SmartYTBJ(func,a,b,y_s,y_e,maxtol)
format long;
node(1) = a;
node(2) = b;
num = 2;
if(b-a)<10 
    n = 5;
else
    n = 10;
end
err = 0;
bSign = 1;
while (bSign)
    bSign = 0;
    for l=1:num
        y(l) = subs(subs(sym(func), findsym(sym(func)),node(l)));
    end
    knode = node;
    tnum = num;
    insert_num = 0;
    for i=1:(tnum-1)
        pfx = ThrSample1(knode,y,y_s,y_e,((knode(i)+knode(i+1))/2));
        %上式给出每个分段区间上的样条插值函数
        [mx,mv] = FindMX(func,pfx,knode(i),knode(i+1),n); 
        %找到区间[knode(i),knode(i+1)]上的误差最大的点
        if mv > maxtol   
        %如果误差超过给定精度，在此点将区间[knode(i),knode(i+1)]分为两段，即将此点加
        %入结点数组中
            d(1:(i+insert_num)) = node(1:(i+insert_num));
            d(i+insert_num+1) = mx; 
            num = num+1;
            d((i+insert_num+2):num) = node((i+insert_num+1):(num-1));   
            node = d;
            bSign = 1;  
            insert_num = insert_num + 1;
        else
            if(mv>err)
                err = mv;           %记录所有样条插值区间上的最大误差
            end
        end
    end    
end
format short;

function [max_x,max_v] = FindMX(func,pfx,a,b,n)
format long;
eps = 1.e-3;
max_v = 0; 
max_x = a;
fa = subs(sym(func), findsym(sym(func)),a);   %左端点函数值
fb = subs(sym(func), findsym(sym(func)),b);   %右端点函数值
step = n/5;
tol = 1;
tmp = 0;
while tol>eps
     t = a;
     for j=0:(n/step)       %此循环找出取最大值的x
         t = a + j*step*(b-a)/n;
         pt = subs(sym(pfx), findsym(sym(pfx)),t); %样条插值得出的函数值
         ft = subs(sym(func), findsym(sym(func)),t);
         if abs(ft-pt)>max_v           %abs(f(x)-p(x))
            max_v = abs(ft-pt);       %记录最大误差
            max_x = t;                %记录此点坐标
         end
     end   
     tol = abs(max_x-tmp);
     tmp = max_x;
     step = step/2;
end
format short;
