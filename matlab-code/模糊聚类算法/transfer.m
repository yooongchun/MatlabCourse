function transfer(X)
% 此函数是用于模糊聚类分析中的传递方法来聚类
% 此函数的输入参数是模糊相似矩阵X
Dimension=size(X);
n=Dimension(1);
m=Dimension(2);
% 检查输入参数的有效性
if n~=m
    error('输入的矩阵必须是方阵');
end
for i=1:(n-1)
    for j=(i+1):n
        if(X(i,j)~=X(j,i)|X(i,j)<0|X(i,j)>1)
            error('输入的矩阵必须满足对称性，或不是模糊相似矩阵');
        end
    end 
end
for i=1:n
    if(X(i,i)~=1)
        error('输入的矩阵必须满足自反性');
    end
end
% 获得模糊相似矩阵中的分类系数矩阵
numda(1)=1;
for i=1:(n-1)
    for j=(i+1):n
        flag=1;
        for k=1:length(numda)
            if X(i,j)==numda(k)
                flag=0;
                break;
            end
        end
        if flag==1
            numda(length(numda)+1)=X(i,j);
        end
    end
end
% 下面程序用于将分类系数矩阵由大到小进行排序
t=1;
for i=1:length(numda)
    ordered_numda(t)=max(numda);
    t=t+1;
    index=find(numda==max(numda));
    numda(index)=[];
end
% 开始聚类操作
for i=1:n
    A(i)=i;
end
for i=1:length(ordered_numda)
    disp('当分类系数是：');
    disp(ordered_numda(i));
    aa=ordered_numda(i);
    AA=A;
    disp('聚类为：');
    loop1=1;
    loop2=1;
    while loop1
        if ~isempty(AA)
            xi=AA(1);
        end
        XX=[];
        Q=[];
        while loop2
            for j=1:n
                if(X(xi,j)>=aa)&isempty(intersect(XX,j))
                    XX=union(XX,j);
                    Q(length(Q)+1)=j;
                end
            end
            if isempty(Q)
                disp(XX);
                break;
            else
                xi=Q(1);
                Q(1)=[];
            end
        end
        AA=setdiff(AA,XX);
        if isempty(AA)
            break;
        end
    end
end