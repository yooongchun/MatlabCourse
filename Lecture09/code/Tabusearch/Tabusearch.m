function [MINL,MINZ,RESULT,best_so_far]=Tabusearch(CS,MS,Z,NT,TL)
hwait = waitbar(0,'正在初始化>>>>');
pause(1);
%把Z转换成q，即把点的位置转换成点的坐标和权值
q=[];
for ii=1:size(Z,2)
    q=[q;CS(Z(1,ii),:)];
end
%初始化禁忌表TA
TA=zeros(1,size(q,1));
TA(TA==0)=inf;
%初始化指针ptr
ptr=1;
waitbar(1/100,hwait,'开始计算>>>>');
[bestF]=findL(q,MS);
result(ptr)=bestF;
%开始搜索
while ptr<NT
    %调用neighbor函数求出邻域
    %并通过findL函数求出领域的所有代价L(i)
    [NEIBR]=neighbor(Z,CS);
    for i=1:size(NEIBR,3)
        Q=NEIBR(:,:,i);
        L(i)=findL(Q,MS);
    end
    %在L(i)中找出最小代价m，及其所在行TI，TI即应变动的点
    m=min(L);
    [x,TI]=find(L==m);
    %if和else之间表示特赦准则的情况
    if m<bestF
        bestF=m;
        sit=TI;
        TA=TA-1;
        TA(TA==0)=inf;
        TA(1,TI)=TL;        
    else%else之后的if表示TI未在禁忌表中标记
        if TA(1,TI)==inf        
            bestF=m;
            TA=TA-1;
            TA(TA==0)=inf;
            TA(1,TI)=TL;
            sit=TI;
        else%else之后表示TI在禁忌表中有标记，m不能用
            %转而找没有被标记的最优点
            [x,ti]=find(TA==inf);
            %如果ti为空，则所有情况被标记，只执行禁忌表-1
            if  isempty(ti)
                TA=TA-1;
                TA(TA==0)=inf;
            else
                %如果ti不为空，则找出未被标记情况中的最小代价解
                for j=1:size(ti)
                    mimi(j)=L(ti(j));
                end
                bestF=min(mimi);
                [x,t]=find(L==bestF);
                TA=TA-1;    
                TA(TA==0)=inf;
                TA(1,t)=TL;
                sit=t;
            end
        end
    end
    %q转换成Z
    q=NEIBR(:,:,sit);
    for k=1:size(q,1)
        Z(k)=findrow(CS(:,1:2),q(k,1:2));
    end
    if ptr>0.5*NT
        mi=min(result);
        if mi==bestF
            MINZ=Z;
        end
    end
    %记录第ptr次搜索时的当前最小代价
    best_so_far(ptr)=min(result);
    ptr=ptr+1;
    %记录第ptr次搜索时解的代价值
    result(ptr)=bestF;
    str=['计算完成' num2str(((ptr-1)/NT)*100) '%...'];
    waitbar(ptr/NT,hwait,str);
end
best_so_far(ptr)=min(result);
RESULT=result;
MINL=min(result);
waitbar(99/100,hwait,'正在绘图>>>>');
pause(1);
waitbar(100/100,hwait,'完成！！');
end


