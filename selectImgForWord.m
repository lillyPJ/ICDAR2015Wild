% selectImgForWord
% from png to jpg(loss)
CASE = 'train';
sourceDataBase = '/home/lili/datasets/ICDAR2015Wild/raw';
destDataBase = '/home/lili/datasets/ICDAR2015WildWord';
imgNameFile = fullfile(sourceDataBase, 'figWord', [CASE, 'Name_word.txt']);
imgNames = importdata(imgNameFile);

sourceImgDir = fullfile(sourceDataBase, [CASE, 'Data']);
destImgDir = fullfile(destDataBase, 'img', CASE);
mkdir(destImgDir);
nImg = length(imgNames);
for i = 1:nImg
    imgRawName = imgNames{i};
    fprintf('%d:%s\n', i, imgRawName);
    sourceImgFile = fullfile(sourceImgDir, imgRawName);
    destImgFile = fullfile(destImgDir, [imgRawName(1:end-3), 'jpg']);
    image  = imread(sourceImgFile);
    imwrite(image, destImgFile, 'Quality', 100);
end


