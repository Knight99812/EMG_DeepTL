function DPR_feature=DPR_extract(EMG,fs)

Nchannel=size(EMG,1);

DPR_feature=zeros(1,Nchannel);


for i=1:Nchannel
    DPR_feature(i)=myDPR(EMG(i,:),fs);
end