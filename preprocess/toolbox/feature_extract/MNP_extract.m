function MNP_feature=MNP_extract(EMG,fs)

Nchannel=size(EMG,1);

MNP_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MNP_feature(i)=myMNP(EMG(i,:),fs);
end