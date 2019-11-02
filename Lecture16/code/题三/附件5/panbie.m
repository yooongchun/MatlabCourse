%此为功能函数，用于识别两个图像是否满足连续相邻，可共同目录下调用但不能单独运行
function [k]=panbie1(W,bm,n)    

k=find(W(n,:)==min(W(n,:)));
lo=length(k);
if(lo>1)  %当出现多个较优的可行解时
    k
    for i=1:lo
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{k(i),1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
    end
    b=input('人工干预');  %判断是否有满足连续的邻接图
    if(b==0)
        for i=1:lo
            W(n,k)=inf;   %将这些不满足的情况剔除
        end
        close all;
        [k]=panbie(W,bm,n); %循环调用函数
    else
            k=k(b);
    end
end
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{k,1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
        b=input('识别');
        if(b==0)
            W(n,k)=inf;
            close all;
            [k]=panbie(W,bm,n);
        else
            k=k;
            W(n,k)=inf;
        end
