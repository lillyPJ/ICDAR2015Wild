%preparePolyChineseWordDemo
CASE = 'train';
DISPLAY = 0;

destGtBase = '/home/lili/datasets/ICDAR2015WildWord';
sourceGtBase = '/home/lili/datasets/ICDAR2015Wild/raw/';
sourceGtDir = fullfile(sourceGtBase, [CASE, 'Data']);
destGtDir = fullfile(destGtBase, 'gt', CASE, 'txt', 'polyChineseWord');
mkdir(destGtDir);
imgDir = fullfile(destGtBase, 'img', CASE);
%
imgFiles = dir(fullfile(imgDir, '*.jpg'));
nImg = numel(imgFiles);
for i = 1:nImg
    imgRawName = imgFiles(i).name;
    fprintf('%d:%s\n', i, imgRawName);
    % load gt
    sourceGtFileName = fullfile(sourceGtDir, [imgRawName(1:end-3), 'png.text_box']);
    destGtFileName = fullfile(destGtDir, [imgRawName(1:end-3), 'txt']);
    sourceGt = [];
    if exist(sourceGtFileName, 'file')
        fp = fopen(sourceGtFileName);
        sourceGtData = textscan(fp,'%d %d %d %d %d %d %d %d %d %s');
        fclose(fp);
        nGt = length(sourceGtData);
        if nGt > 0
            charInfo = sourceGtData{end}; % Chinese or English char
            charInfo = [charInfo{:}];
            flags = strChinese(charInfo);
            idx = (flags > 0);
            allBox = cell2mat(sourceGtData(2:end-1)); %   
            sourceGt = round(allBox(idx, :)); 
        end
    end
    if DISPLAY
        image = imread(fullfile(imgDir, imgRawName));
        imshow(image);
        displayPoly(sourceGt);
    end
    % write to destGt
    fp = fopen(destGtFileName, 'wt');
    if ~isempty(sourceGt)
        fprintf(fp, '%d, %d, %d, %d, %d, %d, %d, %d, "2"\n', sourceGt');
    end
    fclose(fp);
    
end
