% testShowCharDemo


CASE = 'train';
%% dirs and files
dataBase = '/home/lili/datasets/ICDAR2015Wild/raw';
dataDir = [CASE, 'Data'];
imgDir = fullfile(dataBase, dataDir);
gtDir = imgDir;
ext = '.text_box';

%%
imgFiles = dir(fullfile(imgDir, '*.png'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    image = imread(fullfile(imgDir,  imgRawName));
    gtFile = fullfile(gtDir, [imgRawName, ext]);
    %gtData = textread(gtFile, '%d %d %d %d %d %d %d %d %d %d %s');
    fp = fopen(gtFile);
    gtData = textscan(fp,'%d %d %d %d %d %d %d %d %d %s');
    fclose(fp);
    nGt = length(gtData);
    if nGt > 0
        flags = gtData{1};
        allBox = cell2mat(gtData(2:end-1));
       
    else
        allBox = [];
    end
    cla;
    imshow(image);
    displayPoly(allBox, 'g');
end