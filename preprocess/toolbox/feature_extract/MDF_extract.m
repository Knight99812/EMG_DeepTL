function MDF_feature=MDF_extract(EMG,fs)

Nchannel=size(EMG,1);

MDF_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MDF_feature(i)=myMDF(EMG(i,:),fs);
end