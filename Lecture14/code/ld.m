f=imread('pic4.png');
w = [2 -1 -1; -1 2 -1;-1 -1 2 ];
g = imfilter(double(f),w);
imshow(g)
gtop = g(1:120,1:120);
figure , imshow(gtop)
gbot = g(end-119:end, end-119:end);
figure,imshow(gbot)
g = abs(g);
figure,imshow(g)
T = max (g(:));
g = g >= T;
figure, imshow(g)
