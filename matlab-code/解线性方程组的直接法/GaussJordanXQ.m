function [x,XA]= GaussJordanXQ (A,b) 
N = size(A);
n = N(1);
index = 0;
pos = zeros(n,1);
B = A;

for i=1:n
    me = max(abs(B(1:n,i)));         %选取列主元
    for k=1:n
        if(abs(A(k,i))==me)
            index = k;
            pos(i,1) = k;            %保存列主元所在的行号
            break;
        end
    end
    m = A(index,i);
    for j=1:n
        if(j ~= index)
            l = A(j,i);          
            A(j,1:n)=A(j,1:n)-l*A(index,1:n)/m;
            b(j)=b(j)-l*b(index)/m;   %消元
        end
    end
    B = A;
    for k=1:n
        if(pos(k,1)~=0)
            B(pos(k,1),1:n)=0;        %避免列主元在同一行
        end
    end
end

XA = A;
for i=1:n
    x(i,1)=b(pos(i,1))/A(pos(i,1),i);  %求解
end
