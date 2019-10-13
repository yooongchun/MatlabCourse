function df=FivePoint(func,x0,type,h)
if nargin == 3 
    h = 0.1;
else if (nargin == 4 && h == 0.0)
        disp('h不能为0！');
        return;
    end
end

y0 = subs(sym(func), findsym(sym(func)),x0);
y1 = subs(sym(func), findsym(sym(func)),x0+h);
y2 = subs(sym(func), findsym(sym(func)),x0+2*h);
y3 = subs(sym(func), findsym(sym(func)),x0+3*h);
y4 = subs(sym(func), findsym(sym(func)),x0+4*h);
y_1 = subs(sym(func), findsym(sym(func)),x0-h);
y_2 = subs(sym(func), findsym(sym(func)),x0-2*h);
y_3 = subs(sym(func), findsym(sym(func)),x0-3*h);
y_4 = subs(sym(func), findsym(sym(func)),x0-4*h);

switch type
    case 1,
        df = (-25*y0+48*y1-36*y2+16*y3-3*y4)/(12*h);   %用第一个公式求导数
       
    case 2,
        df = (-3*y_1-10*y0+18*y1-6*y2+y3)/(12*h);     %用第二个公式求导数
        
    case 3,
        df = (y_2-8*y_1+8*y1-y2)/(12*h);               %用第三个公式求导数
         
    case 4,
        df = (3*y1+10*y0-18*y_1+6*y_2-y_3)/(12*h);    %用第四个公式求导数
             
    case 5,
        df = (25*y0-48*y_1+36*y_2-16*y_3+3*y_4)/(12*h);  %用第五个公式求导数
end