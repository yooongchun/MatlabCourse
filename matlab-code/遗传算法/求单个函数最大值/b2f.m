%解码

function [fval] = b2f(bval,bounds,bits)
% fval   - 表征各变量的十进制数
% bval   - 表征各变量的二进制编码串
% bounds - 各变量的取值范围
% bits   - 各变量的二进制编码长度
scale=(bounds(:,2)-bounds(:,1))'./(2.^bits-1); %The range of the variables
numV=size(bounds,1);
cs=[0 cumsum(bits)];
for i=1:numV
  a=bval((cs(i)+1):cs(i+1));
  fval(i)=sum(2.^(size(a,2)-1:-1:0).*a)*scale(i)+bounds(i,1);
end
