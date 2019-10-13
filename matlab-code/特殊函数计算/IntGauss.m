function q = IntGauss(f,a,b,n,AK,XK)
%被积函数：f；
%积分区间左端点：a；
%积分区间右端点：b；
%所采用的高斯积分点个数：n；
%自定义系数：AK
%自定义积分点：XK；
%积分值：q；

if(n<5 && nargin == 4)
    AK = 0;
    XK = 0;
else
    if  n>5                                              %如果n>4，则节点和系数由调用者给出
        XK1=((b-a)/2)*XK+((a+b)/2);
        q=((b-a)/2)*sum(AK.*subs(sym(f),findsym(f),XK1));
    end
end

ta = (b-a)/2;
tb = (a+b)/2;
 

switch n
    case 1, %n＝1时，采用表6-1中对应的系数 和 进行计算
        q=2*ta*subs(sym(f),findsym(sym(f)),tb);
        
    case 2, %n＝2时，采用表6-1中对应的系数 和 进行计算
        q=ta*(subs(sym(f),findsym(sym(f)),ta*0.5773503+tb)+...
            subs(sym(f),findsym(sym(f)),-ta*0.5773503+tb));
        
    case 3, %n＝3时，采用表6-1中对应的系数 和 进行计算
        q=ta*(0.55555556*subs(sym(f),findsym(sym(f)),ta*0.7745967+tb)+...
            0.55555556*subs(sym(f),findsym(sym(f)),-ta*0.7745967+tb)+...
            0.88888889*subs(sym(f),findsym(sym(f)),tb));
           
    case 4, %n＝4时，采用表6-1中对应的系数 和 进行计算
        q=ta*(0.3478548*subs(sym(f),findsym(sym(f)),ta*0.8611363+tb)+...
            0.3478548*subs(sym(f),findsym(sym(f)),-ta*0.8611363+tb)+...
            0.6521452*subs(sym(f),findsym(sym(f)),ta*0.3398810+tb)...
            +0.6521452*subs(sym(f),findsym(sym(f)),-ta*0.3398810+tb));
   case 5,  %n＝5时，采用表6-1中对应的系数 和 进行计算
        q=ta*(0.2369269*subs(sym(f),findsym(sym(f)),ta*0.9061793+tb)+...
            0.2369269*subs(sym(f),findsym(sym(f)),-ta*0.9061793+tb)+...
            0.4786287*subs(sym(f),findsym(sym(f)),ta*0.5384693+tb)...
            +0.4786287*subs(sym(f),findsym(sym(f)),-ta*0.5384693+tb)+...
            0.5688889*subs(sym(f),findsym(sym(f)),tb));
end
