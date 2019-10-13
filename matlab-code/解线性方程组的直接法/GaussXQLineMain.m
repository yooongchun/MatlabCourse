function [x,XA]=GaussXQLineMain(A,b) 
N = size(A);
n = N(1);
index = 0;

for i=1:(n-1)
    me = max(abs(A(1:n,i)));       %选取列主元
    for k=i:n
        if(abs(A(k,i))==me)
            index = k;             %保存列主元所在的行
            break;
        end
     end
     temp = A(i,1:n);
     A(i,1:n) =  A(index,1:n);
     A(index,1:n) = temp;
     bb = b(index);
     b(index)=b(i);
     b(i) = bb;                    %交换主行
     
     for j=(i+1):n
        if(A(i,i)==0)
            disp('对角元素为0！');
            return;
        end
        l = A(j,i);
        m = A(i,i);
        A(j,1:n)=A(j,1:n)-l*A(i,1:n)/m;     
        b(j)=b(j)-l*b(i)/m;         %消元
    end
end

x=SolveUpTriangle(A,b);             
XA = A;
