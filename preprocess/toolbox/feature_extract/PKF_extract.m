function PKF_feature=PKF_extract(EMG,fs)

Nchannel=size(EMG,1);

PKF_feature=zeros(1,Nchannel);

for i=1:Nchannel
    PKF_feature(i)=myPKF(EMG(i,:),fs);
end