clear all;clc;
load 't4.mat';

%求出误差矩阵
for i = 1:209
    t4{i,1} = double(t4{i,1}); %转化为double型
end
bm=t4;

W=inf*ones(209,209); %W为误差矩阵
afa=1;beta=1;
for i=1:209
    for j=1:209
        W(i,j)=0;
        for k=1:180
        w=(bm{i,1}(k,72)-afa*bm{j,1}(k,1)-beta)^2/180;   
        W(i,j)=W(i,j)+w;
        end
    end
end

%图像二值化处理
for i=1:209
level=graythresh(t4{i,1});
bm{i,1}=im2bw(t4{i,1},level); 
end

%找出每一行的行首图片
k=0;
for i=1:209
    b=0;
    for j=1:9
        b=b+sum(bm{i,1}(:,j));
    end
    if(b==180*9)
        k=k+1;
        left(k)=i;     %每行第一个
    end
end

k=0;
for i=1:209
    b=0;
    for j=1:9
        b=b+sum(bm{i,1}(:,j+63));
    end
    if(b==180*9)
        k=k+1;
        right(k)=i;     %每行最后一个
    end
end

k=0;
for i=1:209
    b=0;
    for j=1:38
        b=b+sum(bm{i,1}(j,:));
    end
    if(b==72*38)
        k=k+1;
        up(k)=i;     %第一行
    end
end

k=0;
for i=1:209
    b=0;
    for j=1:61
        b=b+sum(bm{i,1}(j+119,:));
    end
    if(b==72*61)
        k=k+1;
        down(k)=i;     %最后一行
    end
end

%通过人工干预，找出其中不属于行首的147
left=[20,21,71,82,87,133,'147',160,172,192,202,209];

load 'W.mat';
load 't4.mat';
for i = 1:209
    t4{i,1} = double(t4{i,1}); %转化为double型
end
bm=t4;

left=[20,21,71,82,87,133,'147',160,172,192,202,209];

%以21为行首的其余图片矩阵为例：
n=21;
for ci=1:18
k=find(W(n,:)==min(W(n,:)));
lo=length(k);
if(lo>1)
    k
    for i=1:lo
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{k(i),1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
    end
    b=input('人工干预'); %当出现多个可与当前匹配项时进行人工干预，输入b为人认为较符合匹配的序号
    if(b==0)
        for i=1:lo
            W(n,k)=inf;
        end
        close all;
    else
            k=k(b);
    end
end
    k=k;
    W(n,k)=inf;
    be(ci)=k;
     n=k;
     close all;
end

be %输出以21为行首的其余图片矩阵

%将n变为71得到以71为行首的其余图片矩阵：
n=71;
for ci=1:18
k=find(W(n,:)==min(W(n,:)));
lo=length(k);
if(lo>1)
    k
    for i=1:lo
        s(:,[1:72])=bm{n,1};
        s(:,[73:144])=bm{k(i),1};
        imwrite(s,'lena.jpg','quality',100); 
        figure;
        imshow('lena.jpg')
    end
    b=input('人工干预'); %当出现多个可与当前匹配项时进行人工干预，输入b为人认为较符合匹配的序号
    if(b==0)
        for i=1:lo
            W(n,k)=inf;
        end
        close all;
    else
            k=k(b);
    end
end
    k=k;
    W(n,k)=inf;
    be(ci)=k;
     n=k;
     close all;
end

be %输出以71为行首的其余图片矩阵









    