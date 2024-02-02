function MHW_feature=MHW_extract(EMG,windowNum,overlap)

Nchannel=size(EMG,1);
MHW_feature=[];

for i=1:Nchannel
    MHW_feature=[MHW_feature,myMHW(EMG(i,:),windowNum,overlap)];
end