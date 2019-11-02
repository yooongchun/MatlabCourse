%找每行的行首图片
clear all;clc;  
load 't3.mat';
for i=1:209
level=graythresh(t3{i,1});
bm{i,1}=im2bw(t3{i,1},level);  %图像二值化处理
end


k=0;
for i=1:209
    b=0;
    for j=1:9
        b=b+sum(bm{i,1}(:,j));
    end
    if(b==180*9)
        k=k+1;
        left(k)=i;     %每行的行首
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
        right(k)=i;     %每行的行尾
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


%搜寻每个行首的图片所在行的其余图片
k=0;
for i=1:209
    b=0;
    for j=1:9
        b=b+sum(bm{i,1}(:,j));
    end
    if(b==180*9)
        k=k+1;
        tou(k)=i;     %每行第一个
    end
end

hang=zeros(209,180);
for k=1:209
for i=1:180
    if(sum(bm{k,1}(i,:))==72)  %说明这行是空白的
        hang(k,i)=0;
    else
        hang(k,i)=1;
    end
end
end

for i=1:11
    tu{tou(i),1}(:,1) = -1*ones(180,1);
end

for k=1:11
    for i=1:209
        for j=1:11
              c(k,tou(j))=inf;
        end
          c(k,i)=sum(abs((hang(tou(k),:)-hang(i,:))));
    end
end

for k=1:11
    for p=1:18
        xiao=min(c(k,:));
        [i,j]=find(c(k,:)==xiao);
        h(k,p)=j(1);       %每行表示属于第k行除行首外的图片
        c(k,j(1))=inf;
    end
end

for i=1:18
    for k=1:18
        xs(i,k)=0;
    for j=1:180
        if(bm{h(1,i),1}(j,72)==bm{h(1,k),1}(j,1))
            xs(i,k)=1+xs(i,k);
        end
    end
    end
end
h%每行的元素个数








    