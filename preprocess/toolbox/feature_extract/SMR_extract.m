function SMR_feature=SMR_extract(EMG,fs)

Nchannel=size(EMG,1);

SMR_feature=zeros(1,Nchannel);


for i=1:Nchannel
    SMR_feature(i)=mySMR(EMG(i,:),fs);
end