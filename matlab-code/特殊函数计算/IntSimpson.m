function [q,step] = IntSimpson(f,a,b,type,eps)
%被积函数：f    
%积分下限：a 
%积分上限：b  
%辛普森公式的类型：type
%eps  精度
%积分结果：q    
%积分的子区间数：step

if(type==3 && nargin==4)
    disp('缺少参数！');
end

q=0;

switch type
    case 1,                %辛普森公式
        q=((b-a)/6)*(subs(sym(f),findsym(sym(f)),a)+...
            4*subs(sym(f),findsym(sym(f)),(a+b)/2)+...
            subs(sym(f),findsym(sym(f)),b));
        step=1;
       
    case 2,                %辛普森3/8公式
        q=((b-a)/8)*(subs(sym(f),findsym(sym(f)),a)+...
            3*subs(sym(f),findsym(sym(f)),(2*a+b)/3)+ ...
          3*subs(sym(f),findsym(sym(f)),(a+2*b)/3)+subs(sym(f),findsym(sym(f)),b)); 
        step=1;
        
    case 3,               %复合辛普森公式
        n=2;
        h=(b-a)/2;
        q1=0;
        q2=(subs(sym(f),findsym(sym(f)),a)+subs(sym(f),findsym(sym(f)),b))/h;
        while abs(q2-q1)>eps
            n=n+1;
            h=(b-a)/n;
            q1=q2;
            q2=0;
            for i=0:n-1
                x=a+h*i;
                x1=x+h;
                q2=q2+(h/6)*(subs(sym(f),findsym(sym(f)),x)+...
                    4*subs(sym(f),findsym(sym(f)),(x+x1)/2)+...
                    subs(sym(f),findsym(sym(f)),x1));
            end
        end
        q=q2;
        step=n;
end
