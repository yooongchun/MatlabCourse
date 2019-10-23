function [MS]=MScre(CS) 
for i=0.1:1:max(CS(:,1))+1
    for j=0.1:1:max(CS(:,2))+1
        m=ceil(i);
        n=ceil(j);
        MS(m,n,:)=[i;j];
    end
end
% N=size(CS,1);
% for i=1:N
%     for j=1:N
%         dd(i,j)=((CS(i,1)-CS(j,1))^2+(CS(i,2)-CS(j,2))^2)^0.5;
%     end
% end
% dd(dd==0)=inf;
% DD=dd;
% % DD=sort(dd);
% % DD(1,:)=[];