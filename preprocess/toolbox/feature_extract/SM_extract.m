function SM_feature=SM_extract(EMG,fs,order)

Nchannel=size(EMG,1);

SM_feature=zeros(1,Nchannel);

for i=1:Nchannel
    SM_feature(i)=mySM(EMG(i,:),fs,order);
end