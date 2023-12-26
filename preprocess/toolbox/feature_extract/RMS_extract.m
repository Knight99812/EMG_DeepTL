function RMS_feature=RMS_extract(EMG)

Nchannel=size(EMG,1);

RMS_feature=zeros(1,Nchannel);

for i=1:Nchannel
    RMS_feature(i)=myRMS(EMG(i,:));
end