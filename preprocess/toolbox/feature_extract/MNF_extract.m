function MNF_feature=MNF_extract(EMG,fs)

Nchannel=size(EMG,1);

MNF_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MNF_feature(i)=myMNF(EMG(i,:),fs);
end