function kindX = DistgshAnalysis(XA,XB,SampX)
format long;
sz1 = size(XA);
sz2 = size(XB);
M = sz1(1);         %样本个数
N = sz2(1);
n = sz1(2);

meanXA = mean(XA);
meanXB = mean(XB);

sx = zeros(n,n);
Y = zeros(N,n);
for i=1:n
    for j=1:n
        sx(i,j) = dot(XA(:,i)-meanXA(i)*zeros(M,1),XA(:,j)-meanXA(j)*zeros(M,1))+ ...
              dot(XB(:,i)-meanXB(i)*zeros(N,1),XB(:,j)-meanXB(j)*zeros(N,1));
    end
end

d = transpose(meanXA - meanXB);
c = sx\d;

YA = dot(c,meanXA);
YB = dot(c,meanXB);
Yc =(M*YA + N*YB)/(M+N);
Y0 = dot(c,SampX);
if YA > YB
    if Y0 > Yc
        kindX = 1;
        disp('样品属于第一类');
    else
        if Y0 == Yc
            kindXp = 0 ;
            disp('没法判断');
        else
            kindX = 2;
            disp('样品属于第二类');
        end
    end
else
    if YA < YB
        if Y0 > Yc
            kindX = 2;
            disp('样品属于第二类');
        else
            if Y0 == Yc
                kindX = 0 ;
                 disp('没法判断');
            else
                kindX = 1;
                disp('样品属于第一类');
            end
        end
    else
         disp('没法判断');
    end
end
