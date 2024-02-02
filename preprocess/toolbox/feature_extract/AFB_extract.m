function AFB_feature=AFB_extract(EMG,fs,Wf)

Nchannel=size(EMG,1);

AFB_feature=zeros(1,Nchannel);

for i=1:Nchannel
    AFB_feature(i)=myAFB(EMG(i,:),fs,Wf);
end