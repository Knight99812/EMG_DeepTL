function AR_feature=AR_extract(EMG,order)

order=4;

Nchannel=size(EMG,1);

AR_feature=[];

for i=1:Nchannel
    AR_feature=[AR_feature,myAR(EMG(i,:),order)];
end