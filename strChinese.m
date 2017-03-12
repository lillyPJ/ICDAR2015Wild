function flags = strChinese(str)
% isChinese: flags[i] = 1
% not Chinese: flags[i] = 0
nStr = length(str);
flags = zeros(nStr, 1);
if nStr < 1
    return;
end

for i = 1:nStr
    flags(i) = isChinese(str(i));
end
end