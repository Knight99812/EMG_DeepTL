function OHM_feature=OHM_extract(EMG,fs)

Nchannel=size(EMG,1);

OHM_feature=zeros(1,Nchannel);

for i=1:Nchannel
    OHM_feature(i)=myOHM(EMG(i,:),fs);
end