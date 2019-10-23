function [NEIBR]=neighbor(Z,CS)
cs=CS;
z=Z;
Q=[];
for ii=1:size(Z,2)
    Q=[Q;CS(Z(1,ii),:)];
end
for i=1:size(Z,2)
    cs(z(i),:)=[];
    z=z-1;
end
for k=1:(size(cs)/2)
    NEIBR(:,:,k)=Q;
end
for j=1:(size(cs)/2)
    s=randn(1);
    if s>=0   
        NEIBR(j,:,j)=cs(2*j-1,:);
    else
        NEIBR(j,:,j)=cs(2*j,:);
    end
end
end

        