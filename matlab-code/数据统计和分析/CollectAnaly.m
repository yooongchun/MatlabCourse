function CollectAnaly(X)
format long;
sz = size(X);
N = sz(1);         %样本个数
n = sz(2);
D = zeros(n,n);

totalClass = N;
RecordClass = zeros(N,N+1);
RecordClass(:,1) = ones(N,1);
RecordClass(:,2) = 1:N;
disp('聚类前的N个类：');
disp(RecordClass);

while totalClass > 1
    minClaDist = inf;
    for i=1:totalClass
        for j=i+1:totalClass
            distClass = DistClass(X,RecordClass,i,j,RecordClass(i,1),RecordClass(j,1));
            if distClass < minClaDist
                minClaDist = distClass;
                i1 = i;
                j1 = j;
            end
        end
    end
    t1 = RecordClass(i1,1);
    t2 = RecordClass(j1,1);
    RecordClass(i1,(t1+2):(t1+t2+1)) = RecordClass(j1,2:(t2+1));
    RecordClass(i1,1) = RecordClass(i1,1) + RecordClass(j1,1);
    RecordClass(j1:(totalClass-1),:) = RecordClass((j1+1):totalClass,:);
    RecordClass(totalClass:N,:) = zeros(N-totalClass+1,N+1);
    totalClass = totalClass - 1;
    str1 = strcat('第',num2str(N - totalClass));
    str1 = strcat(str1, '次聚类，');
    str1 = strcat(str1, '第');
    str1 = strcat(str1, num2str(i1));
    str1 = strcat(str1, '类和第');
    str1 = strcat(str1, num2str(j1));
    str1 = strcat(str1, '类合并：');
    disp(str1);
    disp(RecordClass(1:totalClass,:))
end


function d = DistSamp(X1,X2)
format long;
d = sqrt(dot( X1-X2,X1-X2));
format short;

function d = DistClass(X,C1,l1,l2,n,m)
format long;
d = inf;
for i=1:n
    for j=1:m
        dc = DistSamp(X(C1(l1,i+1),:),X(C1(l2,j+1),:));
        if dc < d
            d = dc;
        end
    end
end
format short;