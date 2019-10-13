function q = IntGaussLager(f,n,AK,XK) 
%被积函数：f；
%所采用的积分点个数：n；
%自定义系数：AK
%自定义积分点：XK；
%积分值：q；

if(n<6 && nargin == 2)
    AK = 0;
    XK = 0;
else
    q=sum(AK.*subs(sym(f),findsym(f),XK));
end

switch n
    case 2,               %n＝2时，采用表6-5中对应的系数进行计算
        q=0.853553*subs(sym(f),findsym(sym(f)),-0.585786)+...
            0.146447*subs(sym(f),findsym(sym(f)),3.414214);
        
    case 3,               %n＝3时，采用表6-5中对应的系数进行计算
        q=0.711093*subs(sym(f),findsym(sym(f)),0.415575)+...
            0.278518*subs(sym(f),findsym(sym(f)),2.294280)+...
            0.0103893*subs(sym(f),findsym(sym(f)),6.289945);
        
    case 4,               %n＝4时，采用表6-5中对应的系数进行计算
        q=0.603154*subs(sym(f),findsym(sym(f)),0.322548)+...
            0.357419*subs(sym(f),findsym(sym(f)),1.745761)+...
            0.0388879*subs(sym(f),findsym(sym(f)),4.536620)+...
            0.000539295*subs(sym(f),findsym(sym(f)),9.395071);
           
    case 5,              %n＝5时，采用表6-5中对应的系数进行计算
        q=0.521756*subs(sym(f),findsym(sym(f)),0.263560)+...
            0.398667*subs(sym(f),findsym(sym(f)),1.413403)+...
            0.0759424*subs(sym(f),findsym(sym(f)),3.596426)+...
            0.00361176*subs(sym(f),findsym(sym(f)),7.085810)+...
            0.0000233700*subs(sym(f),findsym(sym(f)),12.640801);  
end
