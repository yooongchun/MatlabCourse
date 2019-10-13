function df= FivePoint2(func,x0,type,h)
if nargin == 3 
    h = 0.1;
else if (nargin == 4 && h == 0.0)
        disp('h不能为0！');
        return;
    end
end

for i=1:9
     y(i) = subs(sym(func), findsym(sym(func)), x0-4*h+i*h-h);
end
hd = 1/12/h/h;

switch type
    case 1,
        df = (35*y(5)-104* y(6)+114* y(7)-56* y(8)+11* y(9))*hd;   %用第一个公式求导数
       
    case 2,
        df = (11*y(4)-20* y(5)+6* y(6)+4* y(7)- y(8))*hd;     %用第二个公式求导数
        
    case 3,
        df = (-y(3)+16* y(4)-30* y(5)+16* y(6)- y(7))*hd;       %用第三个公式求导数
         
    case 4,
        df = (-y(2)+4*y(3)-6*y(4)+20*y(5)+11*y(6))*hd;    %用第四个公式求导数
             
    case 5,
        df = (35*y(5)-104* y(4)+114* y(3)-56* y(2)+11* y(1))*hd;  %用第五个公式求导数
end
