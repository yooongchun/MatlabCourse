rng(sum(clock));
p0=0;
tic
for i=1:10^6
x=99*rand(5,1);
x1=floor(x);x2=ceil(x);
[f,g]=mengte(x1);
if sum(g<=0)==4
if p0<=f
x0=x1;p0=f;
end
end
[f,g]=mengte(x2);
if sum(g<=0)==4
if p0<=f
x0=x2;p0=f;
end
end
end
fprintf('x1=%.0f\nx2=%.0f\nx3=%.0f\nx4=%.0f\nx5=%.0f\nz=%.0f\n',x0,p0);
toc