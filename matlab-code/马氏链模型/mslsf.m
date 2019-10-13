%  mslsf.m
clc,clear   
format rat 
fid=fopen('data1.txt','r'); 
a=[]; 
while (~feof(fid)) 
    a=[a fgetl(fid)]; 
end 
for i=0:1 
    for j=0:1 
        s=[int2str(i),int2str(j)]; 
        f(i+1,j+1)=length(findstr(s,a)); 
    end 
end 
fs=sum(f'); 
for i=1:2 
    f(i,:)=f(i,:)/fs(i); 
end 
f 