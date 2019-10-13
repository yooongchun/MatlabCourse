%--------------------------------------------------------------------------
%                       基于贝叶斯判别的手写体数字识别
%--------------------------------------------------------------------------

%***********************读取训练样本图片，并进行预处理***********************
% 利用uigetfile函数交互式选取训练样本图片
geshi = {'*.jpg','JPEG image (*.jpg)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'导入外部数据',...
    '*.jpg','MultiSelect','on');
% 如果选择了图片文件，生成图片文件的完整路径，否则退出程序，不再运行后面命令
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % 选择的图片文件个数
% 设置I、BW、training和group的初值
I = zeros(50);
BW = zeros(16);
training = zeros(1,256);
group = [];
% 通过循环对每一个图片进行标准化处理，并生成训练样本数据矩阵training和分组向量group
for i = 1:n
    I = imread(FileFullName{i});  % 读入一幅图片
    I = 255-I;  % 图像反色处理    
    I = im2bw(I,0.4);  % 设定阈值，把反色后图像转成二值图像
    [y,x] = find(I == 1);  % 查找数字上像素点的行标y和列标x
    BW = I(min(y):max(y),min(x):max(x));  % 截取包含数字的最大区域图像
    % 将截取的包含数字的最大区域图像转成16×16的标准化图像
    BW = imresize(BW,[16, 16]);
    % 将标准化图像按列拉长，生成50×256的训练样本矩阵training
    training(i,:) = double(BW(:)');
    % 将图片文件名字符串分成三部分：文件路径、不带扩展名的文件名和扩展名字符串
    [pathstr,namestr,ext] = fileparts(FileName{i});
    % 读取不带扩展名的文件名字符串的第4个字符，得到该图片对应的数字，即该图片所在的组
    group = [group;str2num(namestr(4))];
end


%***************************创建朴素贝叶斯分类器对象*************************
% 创建朴素贝叶斯分类器对象ObjBayes
ObjBayes = NaiveBayes.fit(training,group,'Distribution','mn')


%*****************************对训练样本图片进行判别*************************
% 利用所创建的朴素贝叶斯分类器对象ObjBayes，对训练样本图片进行判别
pre0 = ObjBayes.predict(training);
isequal(pre0, group)  % 判断判别结果pre0与分组向量group是否相等


%***********************读取检验样本图片，并进行预处理***********************
% 利用uigetfile函数交互式选取检验样本图片
geshi = {'*.jpg','JPEG image (*.jpg)';...
       '*.bmp','Bitmap image (*.bmp)';...
       '*.*','All Files (*.*)'};
[FileName FilePath] = uigetfile(geshi,'导入外部数据',...
    '*.jpg','MultiSelect','on');
% 如果选择了图片文件，生成图片文件的完整路径，否则退出程序，不再运行后面命令
if ~isequal([FileName,FilePath],[0,0]);
    FileFullName = strcat(FilePath,FileName);
else
    return;
end
n = length(FileFullName);  % 选择的图片文件个数
% 设置I、BW、sampledata和samplegroup的初值
I = zeros(50);
BW = zeros(16);
sampledata = zeros(1,256);
samplegroup = [];
% 通过循环对每一个图片进行标准化处理，
% 并生成检验样本数据矩阵sampledata和分组向量samplegroup
for i = 1:n
    I = imread(FileFullName{i});  % 读入一幅图片
    I = 255-I;  % 图像反色处理    
    I = im2bw(I,0.4);  % 设定阈值，把反色后图像转成二值图像
    [y,x] = find(I == 1);  % 查找数字上像素点的行标y和列标x
    BW = I(min(y):max(y),min(x):max(x));  % 截取包含数字的最大区域图像
    % 将截取的包含数字的最大区域图像转成16×16的标准化图像
    BW = imresize(BW,[16, 16]);
    % 将标准化图像按列拉长，生成30×256的检验样本矩阵sampledata
    sampledata(i,:) = double(BW(:)');
    % 将图片文件名字符串分成三部分：文件路径、不带扩展名的文件名和扩展名字符串
    [pathstr,namestr,ext] = fileparts(FileName{i});
    % 读取不带扩展名的文件名字符串的第4个字符，得到该图片对应的数字，即该图片所在的组
    samplegroup = [samplegroup; str2num(namestr(4))];
end


%*****************************对检验样本图片进行判别*************************
% 利用所创建的朴素贝叶斯分类器对象ObjBayes，对检验样本图片进行判别
pre1 = ObjBayes.predict(sampledata);
% 查看判别结果
[samplegroup, pre1]    % 第一列为真实组，第二列为判归的组