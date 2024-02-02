function MTW_feature=MTW_extract(EMG,windowNum,overlap)

Nchannel=size(EMG,1);
MTW_feature=[];

for i=1:Nchannel
    MTW_feature=[MTW_feature,myMTW(EMG(i,:),windowNum,overlap)];
end