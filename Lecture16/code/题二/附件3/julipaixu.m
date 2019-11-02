%求解每行的排序，以n=50和15为例：
clear all;clc;format short
load 't3.mat';
load 'hang.mat';
bm=t3;
%求解每行的排序以行首是50的为例：
n=50  
d=[3 12	23	29	193	55	58	66	92	96	119	130	142	144	179	187	189	191];
afa=1;beta=0;
for ci=1:18  
for i=1:18
    ca(i)=0;
    for j=1:180
        w=(bm{n,1}(j,72)-afa*bm{d(i),1}(j,1)-beta)^2/180;
        ca(i)=w+ca(i);
    end
end

    k=find(ca==min(ca));
    lo=length(k);
if(lo>1)
    k
    for i=1:lo
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{d(k(i)),1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
    end
k=input('人工干预');
end
xu(ci)=d(k);
bm{d(k),1}(:,1)=-inf*ones(180,1);
n=d(k);
end
xu  %最终序列

%求解每行的排序以行首是50的为例：
n=15
d=[129,4,160,83,200,136,13,74,161,204,170,135,40,32,52,108,116,177];
afa=1;beta=0;
for ci=1:18  
for i=1:18
    ca(i)=0;
    for j=1:180
        w=(bm{n,1}(j,72)-afa*bm{d(i),1}(j,1)-beta)^2/180;
        ca(i)=w+ca(i);
    end
end

    k=find(ca==min(ca));
    lo=length(k);
if(lo>1)
    k
    for i=1:lo
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{d(k(i)),1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
    end
k=input('人工干预');
end
xu(ci)=d(k);
bm{d(k),1}(:,1)=-inf*ones(180,1);
n=d(k);
end
xu  %最终序列


    