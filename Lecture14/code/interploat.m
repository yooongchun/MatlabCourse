I=imread('pic1.png');
I=I0;
I0=double(I0);
I1=zeros(size(I0,1)*2,size(I0,2)*2,3);
[r,c]=meshgrid(1:size(I0,2),1:size(I0,1));
rc=linspace(1, size(I,1), size(I,1)*2);
cc=linspace(1, size(I,2), size(I,2)*2);
[r_new,c_new]=meshgrid(cc,rc);
rc=linspace(1, size(I0,1), size(I0,1)*2);
cc=linspace(1, size(I0,2), size(I0,2)*2);
[r_new,c_new]=meshgrid(cc,rc);
I1(:,:,1)=interp2(r,c,I0(:,:,1),r_new,c_new,'spline');
I1(:,:,2)=interp2(r,c,I0(:,:,2),r_new,c_new,'spline');
I1(:,:,3)=interp2(r,c,I0(:,:,3),r_new,c_new,'spline');
imshow(uint8(I1))
size(I1)
