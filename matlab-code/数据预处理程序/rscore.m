function [R,xmin,xrange] = rscore(x,dim)
%极差归一化变换
%   R = rscore(X) 对X进行极差归一化变换，这里X可以是一个向量、矩阵或高维数组。
%   若X是一个向量，返回变换后结果向量R = (X–min(X))./range(X)；若X是一个矩阵，
%   则用X的每一列的最小值和极差对该列进行极差归一化变换，返回变换后矩阵R；若X是
%   一个高维数组，则沿X的首个非单一维方向计算最小值和极差，然后对X进行极差归一化
%   变换，返回变换后高维数组R.  例如X是一个1×1×1×4的4维数组，由于X的前三维均
%   为单一维，于是计算X的第4维方向上的最小值和极差，对X进行极差归一化变换，返回
%   的R也是一个1×1×1×4的4维数组。
%
%   [R,xmin,xrange] = rscore(X) 还返回X的最小值xmin = min(X)和极差xrange = range(X).
%
%   [...] = rscore(X,dim) 用dim参数指定沿X的哪个维进行极差归一化变换，例如
%   dim = 1，表示对X的各列进行极差归一化变换；dim = 2，表示对X的各行进行极差归一化变换。
%
%   请参考zscore, min 和 range 函数的用法.

%   Copyright 2009 - 2010 xiezhh. 
%   $Revision: 1.0.0.0 $  $Date: 2009/12/2 15:58:36 $

if isequal(x,[]), z = []; return; end

if nargin < 2
    % Figure out which dimension to work along.
    dim = find(size(x) ~= 1, 1);
    if isempty(dim), dim = 1; end
end

% Compute X's min and range, and standardize it
xmin = min(x,[],dim);
xrange = range(x,dim);
xrange0 = xrange;
xrange0(xrange0==0) = 1;
R = bsxfun(@minus,x, xmin);
R = bsxfun(@rdivide, R, xrange0);
