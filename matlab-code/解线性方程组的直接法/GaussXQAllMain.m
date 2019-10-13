function [x,XA]= GaussXQAllMain (A,b) 
N = size(A);
n = N(1);
index_l = 0;
index_r = 0;
order = 1:n;                           %记录未知数顺序的向量

for i=1:(n-1)
    me = max(max(abs(A(i:n,i:n))));    %选取全主元
    for k=i:n
        for r=i:n
            if(abs(A(k,r))==me)
                index_l = k;
                index_r = r;      %保存主元所在的行和列
                k=n;
                break;
            end
        end
     end
     temp = A(i,1:n);
     A(i,1:n) =  A(index_l,1:n);
     A(index_l,1:n) = temp;
     bb = b(index_l);
     b(index_l)=b(i);
     b(i) = bb;                  %交换主行
     
     temp = A(1:n,i);
     A(1:n,i) = A(1:n,index_r);
     A(1:n,index_r) = temp;       %交换主列
     
     pos = order(i);
     order(i) = order(index_r);
     order(index_r) = pos;        %主列的交换会造成未知数顺序的变化        
     
     for j=(i+1):n
        if(A(i,i)==0)
            disp('对角元素为0！');
            return;
        end
        l = A(j,i);
        m = A(i,i);
        A(j,1:n)=A(j,1:n)-l*A(i,1:n)/m;
        b(j)=b(j)-l*b(i)/m;
    end
end

x=SolveUpTriangle(A,b);

y=zeros(n,1);
for i=1:n
    for j=1:n
        if(order(j)==i)
            y(i)=x(j);
        end
    end
end                      %恢复未知数原来的顺序
x=y;
XA = A;
