clear all;clc;
a1=[23
31
47
67
70
80
98
103
106
126
143
165
167
192
195
204
237
240
259
268
273
314
321
324
339
347
351
363
389
399
412
413];
a1=a1';
n=length(a1);

k=n;
for i=1:n

    if(mod(a1(i),2)==1)
        if((a1(i)+1)~=a1(i+1))
            k=k+1;
            a1(k)=a1(i)+1;
        end
    else
        if(i==1)
            a1(k)=a1(i)-1;
        else
         if((a1(i)-1)~=a1(i-1))
            k=k+1;
            a1(k)=a1(i)-1;
         end
        end
    end
end
            
