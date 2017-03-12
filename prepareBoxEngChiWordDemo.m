% prepareBoxEngChiWordDemo--dest:gt dir
% input-eng: XXX.jpg---[x1,y1,x2,y2]-box
% input-chi: XXX.jpg---[x1,y1,x2,y2]-box
% output: XXX.jpg---[x1,y1,x2,y2]-box

CASE = 'train';
DISPLAY = 0;

destGtBase = '/home/lili/datasets/ICDAR2015WildWord';
sourceEngGtDir = fullfile(destGtBase, 'gt', CASE, 'txt', 'boxEnglishWord');
sourceChiGtDir = fullfile(destGtBase, 'gt', CASE, 'txt', 'boxChineseWord');
destEngChiGtDir = fullfile(destGtBase, 'gt', CASE, 'txt', 'boxWord');
mkdir(destEngChiGtDir);
imgDir = fullfile(destGtBase, 'img', CASE);
gtFiles = dir(fullfile(sourceEngGtDir, '*.txt'));
nGt = numel(gtFiles);
for i = 1:nGt
    sourceEngRawName = gtFiles(i).name;
    fprintf('%d:%s\n', i, sourceEngRawName);
    sourceEngFiles = fullfile(sourceEngGtDir, sourceEngRawName);
    sourceChiFiles = fullfile(sourceChiGtDir, sourceEngRawName);
    destEngChiFiles = fullfile(destEngChiGtDir, sourceEngRawName);
    sourceEngData = importdata(sourceEngFiles);
    sourceChiData = importdata(sourceChiFiles);
    destData = [sourceEngData; sourceChiData];
    % show
    if DISPLAY
        image = imread(fullfile(imgDir, [sourceEngRawName(1:end-3), 'jpg']));
        imshow(image);
        nData = length(destData);
        box = zeros(nData, 4 );
        tag = cell(nData, 1 );
        boxEng = [];
        boxChi = [];
        for j = 1:nData
            fstringCell = regexp( destData{j}, '"', 'split' );
            fboxCell = regexp( fstringCell{1}, ',', 'split' );
            boxTemp = [ str2double(fboxCell{1}), str2double(fboxCell{2}) ...
                str2double(fboxCell{3}), str2double(fboxCell{4}) ];
            tag(j) = fstringCell(2);
            if fstringCell{2} == '1'
                % English
                boxEng = [boxEng; boxTemp];
            else if fstringCell{2} == '2'
                    % Chinese
                    boxChi = [boxChi; boxTemp];
                end
            end
        end
        displayBoxV2(boxEng, 'g');
        displayBoxV2(boxChi, 'b');
    end
    
    % write to destGt
    fp = fopen(destEngChiFiles, 'wt');
    if ~isempty(destData)
        nData = length(destData);
        for j = 1:nData
            fprintf(fp, '%s\n', destData{j});
        end
    end
    fclose(fp);
    
    
end

