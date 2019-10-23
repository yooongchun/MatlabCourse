function DrawRoute(C,R)
%% 画路线图的子函数
% C Coordinate 节点坐标，由一个N×2的矩阵存储
% R Route 路线

N=length(R);
scatter(C(:,1),C(:,2));
hold on
plot([C(R(1),1),C(R(N),1)],[C(R(1),2),C(R(N),2)],'g')

for ii=2:N
    plot([C(R(ii-1),1),C(R(ii),1)],[C(R(ii-1),2),C(R(ii),2)],'g')
end
title('旅行商问题优化结果 ')
hold off