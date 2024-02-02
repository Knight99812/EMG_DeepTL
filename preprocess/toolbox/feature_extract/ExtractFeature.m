% 电极片形状
clc;
clear;
pwd = 'E:\HDsEMG Dataset_V1\Toolbox';
addpath(genpath(pwd));
tempRe3 = [60,61,53,52,44,45,37,36,28,29,21,20,12,13,5,4;...
    59,62,54,51,43,46,38,35,27,30,22,19,11,14,6,3;...
    58,63,55,50,42,47,39,34,26,31,23,18,10,15,7,2;...
    57,64,56,49,41,48,40,33,25,32,24,17,9,16,8,1];
WristOld = 'E:\HDsEMG Dataset_HW\Wrist\';
WristNew = 'E:\HDsEMG Dataset_HW\Wrist_new\';

AllChannel = [1:64];
PartChanOld = reshape([tempRe3(:,1:4),tempRe3(:,13:16)], 1, []);
PartChanNew = reshape(tempRe3(:,5:12), 1, []);

% 提取Old的全部特征
outFile1 = 'D:\guoyao\HW\20211119\Feature\WristOldAllFeature\';
ExtractFeatureFunction(WristOld, AllChannel, outFile1);

outFile2 = 'D:\guoyao\HW\20211119\Feature\WristOldPartYesFeature\';
ExtractFeatureFunction(WristOld, PartChanOld, outFile2);

outFile3 = 'D:\guoyao\HW\20211119\Feature\WristOldPartNoFeature\';
ExtractFeatureFunction(WristOld, PartChanNew, outFile3);

outFile4 = 'D:\guoyao\HW\20211119\Feature\WristNewAllFeature\';
ExtractFeatureFunction(WristNew, AllChannel, outFile4);

outFile5 = 'D:\guoyao\HW\20211119\Feature\WristNewPartYesFeature\';
ExtractFeatureFunction(WristNew, PartChanNew, outFile5);

outFile6 = 'D:\guoyao\HW\20211119\Feature\WristNewPartNoFeature\';
ExtractFeatureFunction(WristNew, PartChanOld, outFile6);

