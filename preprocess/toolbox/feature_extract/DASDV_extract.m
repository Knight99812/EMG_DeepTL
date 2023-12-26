function DASDV_feature=DASDV_extract(EMG)

Nchannel=size(EMG,1);

DASDV_feature=zeros(1,Nchannel);

for i=1:Nchannel
    DASDV_feature(i)=myDASDV(EMG(i,:));
end