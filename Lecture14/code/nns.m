p=3;q=5;
I0=imread('pic3.png');
ii=1;
I1=zeros(round(size(I0,1)*p/q),round(size(I0,2)*p/q),3);
for i=1:q:size(I0,1)-1
  jj=1;
  for j=1:q:size(I0,2)-1
    I1(ii:ii+p-1,jj:jj+p-1,:)=double(I0(i:2:i+q-1,j:2:j+q-1,:));
    jj=jj+p;
  end
  ii=ii+p;
end
figure
image(I0)
% truesize
figure
image(uint8(I1))
% truesize
size(I0),size(I1)