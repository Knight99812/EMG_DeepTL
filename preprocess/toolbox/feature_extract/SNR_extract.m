function SNR_feature=SNR_extract(EMG,EMG_Rest)

Nchannel=size(EMG,1);

SNR_feature=zeros(1,Nchannel);

for i=1:Nchannel
    SNR_feature(i)=mySNR(EMG(i,:),EMG_Rest(i,:));
end