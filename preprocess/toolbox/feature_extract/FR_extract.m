function FR_feature=FR_extract(EMG,fs,fl,fh)

Nchannel=size(EMG,1);

FR_feature=zeros(1,Nchannel);

for i=1:Nchannel
    FR_feature(i)=myFR(EMG(i,:),fs,fl,fh);
end