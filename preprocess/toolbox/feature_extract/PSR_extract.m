function PSR_feature=PSR_extract(EMG,fs,n)

Nchannel=size(EMG,1);

PSR_feature=zeros(1,Nchannel);

for i=1:Nchannel
    PSR_feature(i)=myPSR(EMG(i,:),fs,n);
end