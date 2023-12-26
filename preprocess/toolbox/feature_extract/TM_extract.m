function TM_feature=TM_extract(EMG,order)

Nchannel=size(EMG,1);

TM_feature=zeros(1,Nchannel);

for i=1:Nchannel
    TM_feature(i)=myTM(EMG(i,:),order);
end