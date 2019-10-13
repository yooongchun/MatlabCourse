function df= FourPoint(func,x0,type,h)
%采用四点法求函数func在x0处的二阶导数
%函数名: func
%求导点: x0
%四点法的形式： type
%步长 ：h
%导数值： df
if nargin == 3 
    h = 0.1;
else if (nargin == 4 && h == 0.0)
        disp('h不能为0！');
        return;
    end
end

for i=1:7
     y(i) = subs(sym(func), findsym(sym(func)), x0-3*h+i*h-h);
end
hd = 1/6/h/h;

switch type
    case 1,
        df = (12*y(4) - 30*y(5) + 24*y(6) - 6*y(7))*hd;   %用第一个公式求导数
       
    case 2,
        df = (6*y(3) - 12*y(4) + 6*y(5))*hd;     %用第二个公式求导数
        
    case 3,
        df = (12*y(4) - 30*y(3) + 24*y(2) - 6*y(1))*hd;               %用第三个公式求导数
         
end
