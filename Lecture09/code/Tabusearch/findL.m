function [L]=findL(q,MS)
len=size(q);
CZ=0;
DZ=0;
m=size(MS,1);
n=size(MS,2);
CZ=sum(q(:,3));
for i=1:(m*n)
    for j=1:size(MS,1)
        for k=1:size(MS,2)
            for l=1:len
            d(l)=((MS(j,k,1)-q(l,1))^2+(MS(j,k,2)-q(l,2))^2)^0.5;
            end
            D=min(d);
            [x,y]=find(d==D);
            DZ=DZ+D;
        end
    end
end
L=DZ+CZ;

            
    
    
    
    
    
    
    
    
    
    
    
    
    
    