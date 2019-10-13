function  [IMCom, NumPrin] = ImCompressPrin(filename,q)
%基于主成分分析的图像压缩
%
%   ImCompressPrin(filename,q) 显示由前q个主成分的得分矩阵和系数矩阵恢复的图像.
%   输入参数filename是一个由单引号括起来的字符串，用来指定图片文件的文件名，如
%   'football.jpg'. 如果图片文件不在MATLAB当前文件夹或搜索路径下，应在filename
%   中指定图片文件的完整路径. 输入参数q是一个正整数或(0,1)内的实数，若为正整数，
%   用来指定恢复图像时用到的主成分的个数；若为(0,1)内的实数，用来指定图像压缩比
%   的倒数，程序中会根据q的值自动确定用到的主成分的个数. 
%
%   IMCom = ImCompressPrin(filename,q) 输出由前q个主成分的得分矩阵和系数矩阵恢
%   复的图像数据IMCom.
%
%   [IMCom, NumPrin] = ImCompressPrin(filename,q) 还返回恢复图像时用到的主成
%   分的个数或图像压缩比的倒数. 当输入参数q是一个(0,1)内的实数时，NumPrin是用到
%   的主成分的个数；当q是一个正整数时，NumPrin是图像压缩比的倒数.
%
%   Copyright 2009 xiezhh.
%   $Revision: 1.0.0.0 $  $Date: 2009/10/18 12:20:30 $

% 读入一幅图片，并求图像数据的大小
I = imread(filename);
[nrow,ncol,npage] = size(I);
% 确定图像分块的个数
nrow = floor(nrow/16);
ncol = floor(ncol/16);
% 确定最多可用的主成分的个数m
n = nrow * ncol;
p = npage*256;
m = floor(n*p/(n+p));
% 根据q的取值，确定所用的主成分的个数qid
if q > 0 && q < 1
    qid = ceil(m*q); 
elseif q >= 1 && q <= m && round(q) ==q
    qid = q;
else
    error(['q的取值应为(0,1)内的数或不超过', num2str(m),'的正整数'])
end

flag = npage == 3;  % 真彩图像标签，若为真彩图像，flag = 1
% 若I的行数和列数不是16的整数倍，将I的大小进行调整
I = imresize(I,[16*nrow,16*ncol]);
% 将I转化为取值介于0和1之间的双精度数组
I = double(I)/255;
% 显示原始图像
figure(1)
subplot(1,2,1)
imshow(I,[])
% 把原始图像分成nrow×ncol个16×16的小块. I_block为nrow×ncol的元胞数组
if flag
    I_block = mat2cell(I,16*ones(1,nrow),16*ones(1,ncol),npage);
else
    I_block = mat2cell(I,16*ones(1,nrow),16*ones(1,ncol));
end
% 把I_block转为16×16×npage×(nrow×ncol)的数组
x = cat(4,I_block{:});
% 把 x 转为(nrow×ncol)行，(16×16×npage)列的矩阵
x = reshape(x,[16*16*npage,nrow*ncol])';
% 调用pcares函数重建矩阵 x 的数据 xpr
[resid,xpr] = pcares(x,qid);
% 把矩阵xpr转为(nrow*ncol)×1的元胞数组
xpr = mat2cell(xpr,ones(1,nrow*ncol));
% 把xpr的每一个元胞转成16×16×npage的数组
xpr = cellfun(@(x)reshape(x,[16,16,npage]),xpr,'UniformOutput',0);
% 改变元胞数组xpr的形状，使之成为nrow×ncol的元胞数组
xpr = reshape(xpr,[nrow,ncol]);
% 把元胞数组xpr转为nrow×ncol×npage的数组，得到恢复的图像数据I
I = cell2mat(xpr);
% 显示由前qid个主成分的得分矩阵和系数矩阵恢复的图像
subplot(1,2,2)
imshow(I,[])
% 输出恢复的图像数据、用到的主成分个数或图像压缩比的倒数
if nargout > 0
    IMCom = I;
    if q >= 1
        NumPrin = qid/m;
    else
        NumPrin = qid;
    end
end