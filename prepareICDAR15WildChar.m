% prepareICDAR15WildChar

% testShowCharDemo


CASE = 'train';
%% dirs and files
sourceDataBase = '/home/lili/datasets/ICDAR2015Wild/raw';
dataDir = [CASE, 'Data'];
sourceImgDir = fullfile(sourceDataBase, dataDir);
sourceGtDir = sourceImgDir;
ext = '.text_box';

%%
imgFiles = dir(fullfile(sourceImgDir, '*.png'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    image = imread(fullfile(sourceImgDir,  imgRawName));
    gtFile = fullfile(sourceGtDir, [imgRawName, ext]);
    %gtData = textread(gtFile, '%d %d %d %d %d %d %d %d %d %d %s');
    fp = fopen(gtFile);
    gtData = textscan(fp,'%d %d %d %d %d %d %d %d %d %s');
    fclose(fp);
    nGt = length(gtData);
    if nGt > 0
        flags = gtData{1};
        allBox = cell2mat(gtData(2:end-1));
       
    end
    cla;
    imshow(image);
    displayPoly(allBox, 'g');
end