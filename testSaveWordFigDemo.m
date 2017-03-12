% testSaveWordFigDemo


CASE = 'train';
%% dirs and files
dataBase = '/home/lili/datasets/ICDAR2015Wild/raw';
dataDir = [CASE, 'Data'];
imgDir = fullfile(dataBase, dataDir);
gtDir = imgDir;
ext = '.gt';
destFigDir = fullfile(dataBase, 'figWord', CASE);
mkdir(destFigDir);
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
    gtData = textscan(fp,'%d %d %d %d %d %d %d %d %d %d %s');
    fclose(fp);
    nGt = length(gtData);
    if nGt > 0
        flags = gtData{1};
        allBox = cell2mat(gtData(3:end-1));
        badBox = allBox(flags > 0, :);
        goodBox = allBox(flags < 1, :);
    end
    cla;
    imshow(image);
    displayPoly(goodBox, 'g');
    displayPoly(badBox, 'r');
    saveas(gcf, fullfile(destFigDir, imgRawName));
end