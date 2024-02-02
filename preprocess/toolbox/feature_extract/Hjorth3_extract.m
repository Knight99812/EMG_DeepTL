function Hjorth3_feature=Hjorth3_extract(EMG)

Nchannel=size(EMG,1);

Hjorth3_feature=zeros(1,Nchannel);

for i=1:Nchannel
    Hjorth3_feature(i)=myHjorth3(EMG(i,:));
end